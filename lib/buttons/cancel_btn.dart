// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CancelBTN extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CancelBTN({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: SizedBox(
        width: 120,
        height: 40,
        child: MaterialButton(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.red[400],
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Oxygen',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
