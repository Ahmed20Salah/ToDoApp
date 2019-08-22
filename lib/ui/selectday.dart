import 'package:flutter/material.dart';

class SelectDay extends StatelessWidget {
 final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Day'),
      ),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (BuildContext context , int index){
          return  Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, .6),
                  borderRadius: BorderRadius.circular(10.0)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, '${days[index]}');
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${days[index]}',
                    style: TextStyle(color: Colors.black, fontSize: 23),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
