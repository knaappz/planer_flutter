// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DescBTN extends StatelessWidget {
  final VoidCallback onPressed;

  const DescBTN({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                const Color.fromARGB(255, 225, 185, 147)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ))),
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
