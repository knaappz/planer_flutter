// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditBTN extends StatelessWidget {
  final VoidCallback onPressed;

  const EditBTN({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        onPressed: onPressed,
        color: Colors.orange[100],
        child: Icon(
          Icons.edit,
          size: 30,
        ),
      ),
    );
  }
}
