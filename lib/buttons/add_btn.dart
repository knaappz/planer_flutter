// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';

class AddBTN extends StatelessWidget {
  final VoidCallback onPressed;

  const AddBTN({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 8,
      onPressed: onPressed,
      backgroundColor: MyColors.aBColor,
      child: Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
