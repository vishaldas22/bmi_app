import 'package:flutter/material.dart';
import 'package:bmi_app/ui/Constants.dart';

class Metrics extends StatefulWidget {
  @override
  _MetricsState createState() => _MetricsState();
}

class _MetricsState extends State<Metrics> {
  final TextEditingController _weightController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  VoidCallback _showModalBottomSheet;

  double _finalResult = 0;
  String _formattedText = "";
  String _result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showModalBottomSheet = _showBottomSheet;
  }

  _showSnackBar() {
    final snackbar =
        new SnackBar(content: new Text("Please enter the details first!"));

    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 80.0,
            child: new Row(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 20.0, bottom: 8.0),
                  child: new CircleAvatar(
                    child: Image.asset('images/me.jpg'),
                    radius: 30.0,
                  ),
                ),
                new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: new Text(
                        "Bishal Das",
                        style: new TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 38.0, top: 10.0),
                      child: new Text(
                        "vissudas@gmail.com",
                        style: new TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void calculateBMI() {
    setState(() {
      int age = int.parse(_ageController.text);
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      if (_ageController.text.isNotEmpty ||
          age > 0 && _heightController.text.isNotEmpty ||
          height > 0 && _weightController.text.isNotEmpty ||
          weight > 0) {
        _finalResult = weight / (height * height) * 10000;

        if (_finalResult < 18.5) {
          _formattedText = 'You are UnderWeight';
        } else if (_finalResult >= 18.5 && _finalResult <= 24.9) {
          _formattedText = 'You are in Great Shape!!';
        } else if (_finalResult >= 25.0 && _finalResult <= 29.9) {
          _formattedText = 'You are OverWeight';
        } else if (_finalResult > 30) {
          _formattedText = 'You are Obesse';
        } else {
          _finalResult = 0;
        }
        _result = "Your BMI is : ${_finalResult.toStringAsFixed(1)}";
      }
    });
  }

  choiceAction(String choice) {
    if (choice == Constants.developer) {
      return _showBottomSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
          title: new Text("Metrics"),
          centerTitle: true,
          actions: <Widget>[
            new PopupMenuButton(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choice.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })
          ],
          backgroundColor: Colors.pink),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: new Text(
              "Calculate in centimeters & kilogram",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new TextField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: InputDecoration(
                  labelText: "AGE",
                  labelStyle: TextStyle(fontSize: 18.0),
                  hintText: "eg-21",
                  icon: Icon(Icons.person)),
              maxLength: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new TextField(
              keyboardType: TextInputType.number,
              controller: _weightController,
              decoration: InputDecoration(
                  labelText: "Weight in kgs",
                  labelStyle: TextStyle(fontSize: 18.0),
                  hintText: "eg-85",
                  icon: Icon(Icons.line_weight)),
              maxLength: 6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new TextField(
              keyboardType: TextInputType.number,
              controller: _heightController,
              decoration: InputDecoration(
                  labelText: "Height in centimeters",
                  labelStyle: TextStyle(fontSize: 18.0),
                  hintText: "eg-105.7",
                  icon: Icon(Icons.vertical_align_top)),
              maxLength: 6,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: new RawMaterialButton(
                onPressed: calculateBMI,
                shape: CircleBorder(),
                fillColor: Colors.pink,
                padding: EdgeInsets.all(40.0),
                child: new Text(
                  "Calculate",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Center(
            child: new Text(
              "$_result",
              style: new TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22.0,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Center(
            child: new Text(
              "$_formattedText",
              style: new TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 22.0,
                  fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}
