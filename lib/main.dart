import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_app/scope/control_model.dart';
import 'ui/home.dart';
import 'ui/tasks.dart';

main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Todo_App',
      home: ScopedModel(
        model: manage_model(),
        child: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[Home(), Task()],
        ),
      ),
    ),
  );
}
