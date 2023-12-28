import 'package:hive/hive.dart';

// ignore: camel_case_types
class taskDataBase {
  List taskList = [];

  // reference
  final _mybox = Hive.box('mybox');

  //first time open app
  void creatInitialData() {
    taskList = [];
  }

  //load data base
  void loadData() {
    taskList = _mybox.get('TASKLIST');
  }

  //update data base
  void updateData() {
    _mybox.put('TASKLIST', taskList);
  }
}
