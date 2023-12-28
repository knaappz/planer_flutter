// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project/buttons/add_btn.dart';
import 'package:project/data_base/data.dart';
import 'package:project/tiles/create_new_task.dart';
import 'package:project/tiles/free_tile.dart';
import 'package:project/tiles/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class MyColors {
  static const Color bgColor = Color.fromRGBO(255, 205, 147, 1);
  static const Color aBColor = Color.fromRGBO(130, 92, 58, 1);
  static const Color tColor = Color.fromRGBO(255, 228, 204, 1);
  static const Color tileColor = Color.fromRGBO(255, 243, 229, 1);
  static const Color addColor = Color.fromRGBO(226, 156, 91, 1);
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  String description = "";
  final _mybox = Hive.box('mybox');
  taskDataBase db = taskDataBase();

  String initialTaskName = '';
  String initialDescription = '';
  DateTime initialDate = DateTime.now();

  DateTime selectedDate = DateTime.now();

  final _controller = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    //załadowanie pustej bazy danych
    if (_mybox.get('TASKLIST') == null) {
      db.creatInitialData();
    } else {
      //załadowanie istniejących danych
      db.loadData();
    }

    super.initState();
  }

  //checkbox zaznaczony
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.taskList[index][2] = value ?? false;
    });
    db.updateData();
  }

  //zapis zadania
  void saveNewTask() {
    setState(() {
      db.taskList.add([
        _controller.text,
        selectedDate,
        false,
        description,
      ]);
      _controller.clear();
      _descriptionController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //utworzenie nowego zadania
  void createNewTask() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CreateTaskDialog(
          controller: _controller,
          descriptionController: _descriptionController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          onDateSelected: (DateTime date) {
            setState(() {
              selectedDate = date;
            });
          },
          onDescriptionChanged: (String newDescription) {
            setState(() {
              description = newDescription;
            });
          },
        );
      },
    );
  }

  //usunięcie zadania
  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateData();
  }

  //sccaffold główna strona
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 234, 210),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.aBColor,
        title: Center(
            child: Text(
          'TAASKZILLA',
          style: TextStyle(
            color: MyColors.tColor,
            fontFamily: 'LondrinaSolid',
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        )),
      ),

      //widget lista tasków w tym tasktile
      body: _buildBody(),
      floatingActionButton: AddBTN(
        onPressed: createNewTask,
      ),
    );
  }

  //widget lista zadań w tym tasktile
  Widget _buildBody() {
    if (db.taskList.isEmpty) {
      //wywołanie 'sigmy', gdy nie ma się zadań do wykonania bo jest się giga chadem w ogarnianiu czasu B)
      return Center(child: FreeTile());
    } else {
      //sortowanie po dacie
      db.taskList.sort((a, b) => a[1].compareTo(b[1]));

      //utworzenie listy zadań
      return ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context, index) {
          DateTime termin = db.taskList[index][1];
          bool terminLine = index == 0 || termin != db.taskList[index - 1][1];

          return Column(
            children: [
              //kafelek sergregujący daty
              if (terminLine)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    color: Color.fromARGB(125, 130, 92, 58),
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        '${termin.day}.${termin.month}.${termin.year}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

              //kafelek tasktile [nazwa, data, czyukończony oraz usunięcie]
              TaskTile(
                taskName: db.taskList[index][0],
                taskDescription: db.taskList[index][3],
                taskDate: db.taskList[index][1],
                taskCompleted: db.taskList[index][2],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunc: (context) => deleteTask(index),
              ),
            ],
          );
        },
      );
    }
  }

  //funkcje formatowania dat
  // ignore: unused_element
  String _formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
