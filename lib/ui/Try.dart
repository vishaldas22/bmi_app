import 'package:flutter/material.dart';
import 'package:bmi_app/ui/Constants.dart';

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();

  final formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double _finalResult = 0;
  String _formattedText = "";
  String _result = "";

  VoidCallback _showModalBottomSheet;

  String _age, _height, _weight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showModalBottomSheet = _showBottomSheet;
  }

  void calculateBMI() {
    setState(() {
      int age = int.parse(_age);
      double weight = double.parse(_weight);
      double height = double.parse(_height);
      var inches = height * 12;

      if (age > 0 && height > 0 && weight > 0) {
        _finalResult = weight / (inches * inches) * 703;

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

  void _submit() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      return calculateBMI();
    } else {
      debugPrint;
    }
  }

  choiceAction(String choice) {
    if (choice == Constants.developer) {
      return _showBottomSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("Try"),
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
        ),
        body: new Form(
          key: formkey,
          child: new ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: new Text(
                  "Calculate in pounds & feet",
                  style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  decoration: InputDecoration(
                      labelText: "Age",
                      hintText: 'eg - 21',
                      labelStyle: TextStyle(fontSize: 18.0),
                      icon: Icon(Icons.person)),
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  validator: (input) =>
                      input.isEmpty ? 'Please enter the age' : null,
                  onSaved: (input) => _age = input,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  decoration: InputDecoration(
                      labelText: "Weight in lbs",
                      hintText: 'eg - 180',
                      labelStyle: TextStyle(fontSize: 18.0),
                      icon: Icon(Icons.line_weight)),
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (input) =>
                      input.isEmpty ? 'Please enter the weight' : null,
                  onSaved: (input) => _weight = input,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  decoration: InputDecoration(
                      labelText: "Height in feet & inches",
                      hintText: 'eg - 5.9',
                      labelStyle: TextStyle(fontSize: 18.0),
                      icon: Icon(Icons.vertical_align_top)),
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  validator: (input) =>
                      input.isEmpty ? 'Please enter the height' : null,
                  onSaved: (input) => _height = input,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new RawMaterialButton(
                    onPressed: _submit,
                    shape: CircleBorder(),
                    fillColor: Colors.blue,
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
        ));
  }
}
