import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_app/scope/control_model.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  // set the defulte color value(black)
  var _color = Color(0xff151515);

  @override
  Widget build(BuildContext context) {
    // fetching data from database before build tasks screen  
     ScopedModel.of<manage_model>(context).fetchdata();

    return Scaffold(
      backgroundColor: _color,
      body: Container(
        color: _color,
        padding: EdgeInsets.only(left: 20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 220.0,
            ),
            Container(
              height: 144.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'My Tasks',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 23.0),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'My Tasks',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tomica'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Flutter App',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 23.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Choose Your Color',
                    style: TextStyle(fontSize: 23),
                  ),
//                      SizedBox(
//                        height: 5.0,
//                      ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 40.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: _color.withOpacity(0.5),
          height: 72.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: Color(0xffF44336),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xffF44336);
                    });
                  },
                ),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Color(0xffFFC400)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xffFFC400);
                    });
                  },
                ),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Color(0xff2962FF)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xff2962FF);
                    });
                  },
                ),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Color(0xff311B92)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xff311B92);
                    });
                  },
                ),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Color(0xff00E676)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xff00E676);
                    });
                  },
                ),
              ),
              Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    color: Color(0xff151515)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _color = Color(0xff151515);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
