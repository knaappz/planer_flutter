// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/pages/home_page.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //open box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}
