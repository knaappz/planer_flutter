// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/buttons/start_btn.dart';
import 'package:project/buttons/termin_btn.dart';
import 'package:project/pages/home_page.dart';

class CreateTaskDialog extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController descriptionController;
  final Function(String)? onDescriptionChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(DateTime)? onDateSelected;

  const CreateTaskDialog({
    Key? key,
    required this.controller,
    required this.descriptionController,
    required this.onDescriptionChanged,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  DateTime _datetime = DateTime.now();
  bool isDateSelected = false;

  //wywołanie kalendarza
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2027),
    ).then((value) {
      if (value != null) {
        setState(() {
          _datetime = value;
          isDateSelected = true;
          widget.onDateSelected?.call(_datetime);
        });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  //sprawdzenie, czy pole na nazwe zadania jest puste
  String? _validateInput(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Pole nie może być puste!';
    }
    return null;
  }

  //alert dialog
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: MyColors.tColor,
      content: Container(
        width: 300,
        height: 430,
        child: Column(
          children: [
            //tytuł
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Nowe zadanie:',
                style: TextStyle(
                  fontFamily: 'Oxygen',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            //input nazwy zadania
            Form(
              key: _formKey,
              child: TextFormField(
                maxLines: 1,
                maxLength: 30,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Podaj nazwe zadania...",
                ),
                validator: _validateInput,
              ),
            ),

            //input opisu (nie działa)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                child: TextFormField(
                  maxLength: 40,
                  controller: widget.descriptionController,
                  onChanged: (value) {
                    widget.onDescriptionChanged?.call(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Dodaj krótki opis...",
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //sprawdzenie czy wybrano termin
                  isDateSelected
                      ? Text(
                          'Wybrana data: ${DateFormat('dd.MM.yyyy').format(_datetime)}',
                          style: TextStyle(
                              color: MyColors.aBColor,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        )
                      : Text(
                          'Ustaw date by zapisać...',
                          style:
                              TextStyle(color: Colors.brown[400], fontSize: 13),
                        ),

                  //wybór terminu
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TerminBTN(
                        onPressed: _showDatePicker, text: 'Wybierz termin'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //zapisz
                        StartBTN(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  isDateSelected == true) {
                                widget.onSave();
                              }
                            },
                            text: 'Zapisz'),

                        //wstecz
                        StartBTN(onPressed: widget.onCancel, text: 'Wstecz'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
