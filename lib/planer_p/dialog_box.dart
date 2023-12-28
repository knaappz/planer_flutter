// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:project/buttons/start_btn.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(DateTime)? onDateSelected; // Dodaj tę linijkę

  const DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2027),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          widget.onDateSelected?.call(_dateTime);
        });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  //Empty task name
  String? _validateInput(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Pole nie może być puste!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[300],
      content: SizedBox(
        height: 200,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //user input
              TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Utwórz nowe zadanie',
                ),
                validator: _validateInput,
              ),

              //button save
              Column(
                children: [
                  //date picker
                  StartBTN(
                    text: 'Wybierz termin',
                    onPressed: _showDatePicker,
                  ),

                  //save
                  StartBTN(
                    text: 'Zapisz',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
