import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/task.dart';
import '../lib/db/tasksDb.dart';
void main(){
  
  test('res must increment by 1', (){
    final TasksDatabase db = TasksDatabase();
    var res = db.deleteTask(1);
    expect( res , 1  );
  });
}