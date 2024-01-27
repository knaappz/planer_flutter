// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/buttons/cancel_btn.dart';
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
  final VoidCallback resetDescription;

  const CreateTaskDialog({
    Key? key,
    required this.controller,
    required this.descriptionController,
    required this.onDescriptionChanged,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected,
    required this.resetDescription,
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

  void _resetState() {
    setState(() {
      _datetime = DateTime.now();
      isDateSelected = false;
      widget.controller.clear();
      widget.descriptionController.clear();
    });
  }

  //alert dialog
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                maxLength: 50,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  fillColor: MyColors.txtField,
                  labelText: "Nazwa zadania",
                ),
                validator: _validateInput,
              ),
            ),

            //input opisu
            SizedBox(
              child: TextFormField(
                maxLength: 100,
                controller: widget.descriptionController,
                onChanged: (value) {
                  widget.onDescriptionChanged?.call(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.txtField,
                  border: UnderlineInputBorder(),
                  labelText: "Opis",
                ),
              ),
            ),

            TerminBTN(
              onPressed: () {
                _showDatePicker();
              },
              text: isDateSelected
                  ? 'Wybrano: ${DateFormat('dd.MM.yyyy').format(_datetime)}'
                  : 'Wybierz termin',
            ),
            //wstecz

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CancelBTN(
                  onPressed: () {
                    _resetState();
                    Navigator.of(context).pop();
                  },
                  text: 'Wstecz',
                ),
                StartBTN(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          isDateSelected == true) {
                        widget.onSave();
                        widget.resetDescription();
                      }
                    },
                    text: 'Zapisz'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
