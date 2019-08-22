import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_app/models/task.dart';
import '../db/tasksDb.dart';
import '../models/task.dart';

class manage_model extends Model {
  TasksDatabase _db = TasksDatabase();
  List<Map<String, dynamic>> _data;

  static manage_model of(BuildContext context) =>
      ScopedModel.of<manage_model>(context);

  // to use insert in db file
  Future<int> insert(Map<String, dynamic> value) async {

    TaskModel _task= TaskModel(name: value['name'] , description: value['description'] , day: value['day']);

    int res = await _db.insertTask(_task);
    fetchdata();
    return res;
  }

  // get function
  void fetchdata() async {
    _data = await _db.getAllTasks();
    for(int i = 0; i<_data.length ; i++){
      print(_data[i]);
    }
    notifyListeners();
  }
  // get data var
  List get data => _data;

  List<bool> getStatus(){
    List<bool> _status;
    
  }
  // delete function 
  void delete(int id)async{
    int res = await _db.deleteTask(id);
    print(res);
  }

  // 
  void update(TaskModel data ){
    _db.update(data);
    print(data.id);
  } 
}
