import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_app/models/modes.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/selectday.dart';
import 'package:todo_app/ui/tasks.dart';
import '../scope/control_model.dart';

class AddTask extends StatefulWidget {
  // for switch to editing mode
  Map<String, dynamic> editItem;
  AddTask({this.editItem, this.editMode});

  formMode editMode = formMode.add;
  @override
  State<StatefulWidget> createState() {
    return AddTaskState();
  }
}

class AddTaskState extends State<AddTask> {
  String code;
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  Map<String, dynamic> _data = {
    'id': 0,
    'name': null,
    'description': null,
    'day': null
  };

  @override
  Widget build(BuildContext context) {
    widget.editMode == formMode.edit
        ? _data['day'] = widget.editItem['day']
        : _data['day'] = null;
    widget.editMode == formMode.edit
        ? _data['id'] = widget.editItem['id']
        : _data['id'] = null;
    return ScopedModel<manage_model>(
      model: manage_model(),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Task()));
              },
            )
          ],
          title: Text('Add New'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Task Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color.fromRGBO(255, 255, 255, .6)),
                        child: TextFormField(
                          initialValue: widget.editMode == formMode.edit
                              ? widget.editItem['name']
                              : '',
                          validator: (String value) {
                            if (value.length <= 0) {
                              return 'this required';
                            }
                          },
                          onSaved: (value) {
                            _data['name'] = value;
                          },
                          style: TextStyle(
                              color: Colors.black, height: 1.3, fontSize: 24),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Text(
                        'Description',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Color.fromRGBO(255, 255, 255, .6)),
                        child: TextFormField(
                          initialValue: widget.editMode == formMode.edit
                              ? widget.editItem['description']
                              : '',
                          onSaved: (String value) {
                            _data['description'] = value;
                          },
                          minLines: 3,
                          maxLines: 6,
                          style: TextStyle(
                              color: Colors.black, height: 1.3, fontSize: 24),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      Text(
                        'Task Day',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          _navigateToChooseDay(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color.fromRGBO(255, 255, 255, .6)),
                          child: Center(
                            child: Text(
                              _data['day'] == null
                                  ? 'Tab to Choose a Day'
                                  : '${_data['day']}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_enhance),
                        onPressed: () async {
                          String qresult = await BarcodeScanner.scan();
                          setState(() {
                            code = qresult;
                          });
                        },
                      ),
                      code != null ? Text(code) : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: ScopedModelDescendant<manage_model>(
            builder: (context, _, model) => Container(
                  child: InkWell(
                      child: Text('Add The Task'), onTap: () => _submit(model)),
                )),
      ),
    );
  }

  _navigateToChooseDay(BuildContext context) async {
    _data['day'] = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectDay()),
    );
    print(_data['day']);
  }

  void _submit(model) async {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
      TaskModel _update = TaskModel(
          id: _data['id'],
          name: _data['name'],
          description: _data['description'],
          day: _data['day']);

      if (widget.editMode == formMode.edit) {
        await model.update(_update);
      } else {
        await model.insert(_data);
      }
    }
  }
}
