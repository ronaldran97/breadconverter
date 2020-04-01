import 'package:flutter/material.dart';
import 'package:moneytextformfield/moneytextformfield.dart';
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

  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MoneyTextFormField(
              settings: MoneyTextFormFieldSettings(
                controller: myController
              )
            )
          ],
        )
      ),
    );
    return null;
  }


}
