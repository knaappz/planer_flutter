import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planer_v2/data_base/data.dart';
import 'package:planer_v2/planer_p/dialog_box.dart';
import 'package:planer_v2/planer_p/planer_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  PlanerData db = PlanerData();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    if (_mybox.get('PLANERLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkboxChange(bool? value, int index) {
    setState(() {
      db.planerList[index][2] = value ?? false;
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.planerList.add([_controller.text, selectedDate, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          onDateSelected: (DateTime date) {
            setState(() {
              selectedDate = date;
            });
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.planerList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        title: const Center(
          child: Text('MÓJ PLANER'),
        ),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.planerList.length,
        itemBuilder: (context, index) {
          return PlanerTile(
            taskName: db.planerList[index][0],
            taskDate: db.planerList[index][1],
            taskCompleted: db.planerList[index][2],
            onChanged: (value) => checkboxChange(value, index),
            deleteFunc: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
