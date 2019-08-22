import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_app/scope/control_model.dart';
import 'package:todo_app/ui/addNew.dart';

import '../models/modes.dart';

class Task extends StatefulWidget {
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<Task> {
  mode _mode = mode.one;
  activemode _active = activemode.disable;
  int _index = 0;
  Map<String, dynamic> eidtItem;
  @override
  Widget build(BuildContext context) {
    var data =
        ScopedModel.of<manage_model>(context, rebuildOnChange: true).data;
    print('tasks build');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                if (_mode == mode.one) {
                  _mode = mode.two;
                } else {
                  _mode = mode.one;
                }
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _update,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20.0,
                  childAspectRatio: _mode == mode.one ? 5 : 1,
                  crossAxisCount: _mode == mode.one ? 1 : 2),
              itemCount: data.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == data.length) {
                  return _addNew(context);
                }
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: InkWell(
                    onLongPress: () {
                      setState(() {
                        _active = activemode.active;
                        print(data[index]);
                        _index = data[index]['id'];
                        eidtItem = data[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: _active == activemode.disable
                              ? Color.fromRGBO(255, 255, 255, .6)
                              : Color.fromRGBO(255, 255, 255, .8),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: _active == activemode.disable
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${data[index]['name']}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 23),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${data[index]['name']}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 23),
                                  ),
                                ),
                                // Checkbox(
                                //   value: status[index],
                                //   onChanged: (bool value) {
                                //     setState(() {

                                //     });
                                //   },
                                // )
                              ],
                            ),
                    ),
                  ),
                );
              }),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        color: Colors.black87.withOpacity(.4),
        child: _active == activemode.disable
            ? Center(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.keyboard_arrow_up,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text('Done'),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(
                            editItem: eidtItem,
                            editMode: formMode.edit,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 140.0,
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      ScopedModel.of<manage_model>(context).delete(_index);
                    },
                    child: Container(
                      width: 140.0,
                      child: Text(
                        'Delete',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future _update() async {
    var fun = await ScopedModel.of<manage_model>(context).fetchdata();
    return fun;
  }
}

Widget _addNew(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => AddTask()),
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffeeeeee)),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'Add New Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ),
    ),
  );
}
