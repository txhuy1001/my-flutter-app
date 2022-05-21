import 'package:flutter/material.dart';

void main() {
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(color: Colors.grey)),
                                Expanded(
                                    flex: 2,
                                    child: Container(color: Colors.blue)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(color: Colors.orange)),
                                Expanded(
                                    flex: 2,
                                    child: Container(color: Colors.blue)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(color: Colors.blueAccent)),
                                Expanded(child: Container(color: Colors.blue)),
                                Expanded(child: Container(color: Colors.blue)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(color: Colors.redAccent)),
                                Expanded(child: Container(color: Colors.green)),
                                Expanded(
                                    child: Container(color: Colors.yellow)),
                              ],
                            ),
                          ),
                          Container(
                            height: size.height * 0.25,
                            color: Colors.black,
                          ),
                          Container(
                            height: size.height * 0.25,
                            color: Colors.yellowAccent,
                          ),
                          Container(
                            height: size.height * 0.3,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.43,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Container(
                      width: size.width * 0.25,
                      color: Colors.pinkAccent,
                    ),

                  ],
                ),
                Align(
                  alignment: const FractionalOffset(0.3, 0.58),
                  // heightFactor: 7.0,
                  // widthFactor: 3.0,
                  child: Container(
                    width: size.width * 0.22,
                    height: size.height * 0.15,
                    color: Colors.black54,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(Icons.home),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
