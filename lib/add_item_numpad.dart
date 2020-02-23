import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Break Check',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyNumPadPage(title: 'Break Check'),
    );
  }
}

class MyNumPadPage extends StatefulWidget {
  MyNumPadPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNumPadPageState createState() => _MyNumPadPageState();
}

class _MyNumPadPageState extends State<MyNumPadPage> {

  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  buttonPressed(String buttonText) {


    if (buttonText == "CLEAR") {
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already has a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "="){

    }
    print(_output);
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }



  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.all(24.0),
        child: new Text(buttonText,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        textColor: Colors.black54,
        onPressed: () => {
          buttonPressed(buttonText)
        }, //does nothing
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                  alignment: Alignment.centerRight,
                  padding: new EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 12.0
                  ),
                  child: new Text(output, style: new TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,

                  ),
                  )

              ),


              new Expanded(
                child: new Divider(),
              ),


              new Column(
                children: <Widget>[
                  new Row(children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                  ]),
                  new Row(children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                  ]),
                  new Row(children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                  ]),
                  new Row(children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("CLEAR"),
                  ]),
                  new Row(children: <Widget>[
                    buildButton("SUBMIT")
                  ],)

                ],
              )
            ],
          ),
        ));
  }
}
