// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';

class AddBTN extends StatelessWidget {
  final VoidCallback onPressed;

  const AddBTN({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        elevation: 8,
        onPressed: onPressed,
        backgroundColor: const Color.fromARGB(255, 27, 26, 26),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
