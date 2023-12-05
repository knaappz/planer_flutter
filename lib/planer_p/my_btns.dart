// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyBTN extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyBTN({
    super.key, 
    required this.text, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}