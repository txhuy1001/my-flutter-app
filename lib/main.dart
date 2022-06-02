import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/service/user_service.dart';

import 'view/home_page.dart';


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
