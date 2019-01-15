import 'package:bmi_app/ui/Metrics.dart';
import 'package:bmi_app/ui/Standard.dart';
import 'package:flutter/material.dart';
import 'package:bmi_app/ui/Try.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 100.0)),
          Center(
              child: new Text(
            " Select your mode ",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          )),
          new Padding(padding: EdgeInsets.only(top: 110.0)),
          new RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Metrics()));
            },
            child: new Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 1.0,
            fillColor: Colors.amber,
            padding: const EdgeInsets.all(30.0),
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Center(
              child: new Text(
            "Metrics",
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          )),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          new RawMaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Try()));
              },
              child: new Icon(
                Icons.settings_input_composite,
                color: Colors.white,
              ),
              shape: CircleBorder(),
              elevation: 1.0,
              fillColor: Colors.lightBlueAccent,
              padding: const EdgeInsets.all(30.0)),
          Center(
              child: new Text(
            "Standard",
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          )),
        ],
      ),
    );
  }
}
