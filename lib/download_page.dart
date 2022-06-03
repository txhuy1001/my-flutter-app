import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:my_app/notification/notification_api.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //NotificationApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primaryColor: Colors.lightBlueAccent),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String imageUrl = 'https://randomuser.me/api/portraits/women/68.jpg';
  final String videoUrl = 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4';
  final dio = Dio();
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            SizedBox(
              width: 400,
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.green),
                    backgroundColor: Colors.white,
                  ),
                  Center(
                    child: buildProgress(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  download()
                      .whenComplete(() => NotificationApi.showNotification(
                            title: 'Download Complete',
                            body: 'Finish downloading the video. Check it out!',
                            payload: 'demo.mp4',
                          ));
                },
                icon: const Icon(
                  Icons.download,
                  size: 18,
                ),
                label: const Text('Download')),
          ],
        ),
      ),
    );
  }

  Future<void> download() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = '${appDocDir.path}/demo.mp4';

    await dio.download(videoUrl, savePath,
        onReceiveProgress: (received, total) {
      setState(() {
        progress = received / total;
      });
    });

    await ImageGallerySaver.saveFile(savePath);
  }

  Widget buildProgress() {
    if (progress == 1) {
      return const Text(
        'Done',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        (progress * 100).toStringAsFixed(1),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      );
    }
  }
}
