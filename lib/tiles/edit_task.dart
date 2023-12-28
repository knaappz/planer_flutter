// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:project/buttons/start_btn.dart';
import 'package:project/buttons/termin_btn.dart';
import 'package:project/pages/home_page.dart';
import 'package:intl/intl.dart';

class CreateTaskDialog extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CreateTaskDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  DateTime _datetime = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _datetime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2027),
    );

    if (pickedDate != null && pickedDate != _datetime) {
      setState(() {
        _datetime = pickedDate;
        _dateController.text = DateFormat('yyyy.MM.dd').format(_datetime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: MyColors.tColor,
      content: Container(
        width: 300,
        height: 420,
        child: Column(
          children: [
            Text(
              'Nowe zadanie:',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            //get user input
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Podaj nazwe zadania...",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  maxLines: 5,
                  maxLength: 30,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "Dodaj opis...",
                  ),
                ),
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Wybrana data: ${DateFormat('dd.MM.yyyy').format(_datetime)}',
                    style: TextStyle(
                        color: MyColors.aBColor,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //calendar picker
                TerminBTN(onPressed: _showDatePicker, text: 'Wybierz termin'),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //calendar picker
                      StartBTN(onPressed: widget.onSave, text: 'Zapisz'),

                      //cancel button
                      StartBTN(onPressed: widget.onCancel, text: 'Wstecz')
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
