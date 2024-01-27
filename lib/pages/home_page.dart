// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project/buttons/add_btn.dart';
// import 'package:project/buttons/edit.dart';
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
  static const Color aBColor = Color.fromARGB(255, 48, 47, 47);
  static const Color bgColor = Color.fromRGBO(255, 205, 147, 1);
  static const Color alertColor = Color.fromRGBO(255, 231, 203, 1);
  static const Color txtField = Color.fromRGBO(255, 255, 255, 1);
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
      db.createInitialData();
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
          resetDescription: () {
            setState(() {
              description = '';
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

  //scaffold główna strona
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.aBColor,
        title: Text(
          'TASKZILLA',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'LondrinaSolid',
            fontSize: 40,
            fontWeight: FontWeight.w300,
          ),
        ),
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
          padding: EdgeInsets.all(10),
          itemCount: db.taskList.length,
          itemBuilder: (context, index) {
            DateTime termin = db.taskList[index][1];
            bool terminLine = index == 0 || termin != db.taskList[index - 1][1];
            bool isToday = termin.year == DateTime.now().year &&
                termin.month == DateTime.now().month &&
                termin.day == DateTime.now().day;
            bool isTomorrow = termin.year ==
                    DateTime.now().add(Duration(days: 1)).year &&
                termin.month == DateTime.now().add(Duration(days: 1)).month &&
                termin.day == DateTime.now().add(Duration(days: 1)).day;

            return Column(
              children: [
                //kafelek sergregujący daty
                if (terminLine)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Container(
                      width: 100,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          isToday
                              ? "Dzisiaj"
                              : isTomorrow
                                  ? "Jutro"
                                  : '${termin.day}.${termin.month}.${termin.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),

                //kafelek tasktile [nazwa, data, czyukończony oraz usunięcie]
                Column(
                  children: [
                    TaskTile(
                      taskName: db.taskList[index][0],
                      taskDescription: db.taskList[index][3],
                      taskDate: db.taskList[index][1],
                      taskCompleted: db.taskList[index][2],
                      onChanged: (value) => checkBoxChanged(value, index),
                      deleteFunc: (context) => deleteTask(index),
                    ),
                  ],
                ),
              ],
            );
          });
    }
  }

  //funkcje formatowania dat
  // ignore: unused_element
  String _formatDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
