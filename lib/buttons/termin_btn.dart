// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';

class TerminBTN extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  TerminBTN({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: MaterialButton(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: MyColors.aBColor,
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
