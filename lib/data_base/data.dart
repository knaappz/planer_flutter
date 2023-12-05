import 'package:hive/hive.dart';

class PlanerData {
  List planerList = [];

  //ref our box
  final _mybox = Hive.box('mybox');

  //first time open
  void createInitialData() {
    planerList = [
    
    ];
  }

  //load data
  void loadData() {
    planerList = _mybox.get('PLANERLIST');

  }

  //update database
  void updateDataBase() {
    _mybox.put('PLANERLIST', planerList);
  }
}