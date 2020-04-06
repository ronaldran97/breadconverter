import 'package:break_check/add_item_numpad.dart';
import 'package:break_check/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moneytextformfield/moneytextformfield.dart';

//import 'lib/second_page.dart' as route;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Break Check',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Currency Translator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Language {
  int id;
  String name;

  Language(this.id, this.name);

  static List<Language> getMoneyLanguage() {
    return <Language>[
      Language(1, 'USD (\$)'),
      Language(2, 'JPY (¥)'),
      Language(3, 'EUR (€)'),
      Language(4, 'GBP (£)'),
      Language(5, 'AUD (\$)'),
      Language(6, 'CAD (\$)')
    ];
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String dollarSign = '\$';
  TextEditingController moneyController = TextEditingController(); //for money format
  List<Language> _languages = Language.getMoneyLanguage();
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  Language _selectedLang;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_languages);
    _selectedLang = _dropdownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<Language>> buildDropdownMenuItems(List languages) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language language in languages) {
      items.add(DropdownMenuItem(
        value: language,
        child: Text(language.name),
      ));
    }
    return items;
  }

  onChangeDropdownItem(Language selectedLanguage) {
    setState(() {
      _selectedLang = selectedLanguage;
      print(selectedLanguage.name);
      if (selectedLanguage.name == 'JPY (¥)') {
        dollarSign = '¥';
      } else if (selectedLanguage.name == 'EUR (€)') {
        dollarSign = '€';
      } else if (selectedLanguage.name == 'GBP (£)') {
        dollarSign = '£';
      } else if (selectedLanguage.name == 'AUD (\$)') {
        dollarSign = '\$';
      } else if (selectedLanguage.name == 'CAD (\$)') {
        dollarSign = '\$';
      } else if (selectedLanguage.name == 'USD (\$)') {
        dollarSign = '\$';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              _selectedLang.name, //replace it with a variable that states the
              // currency type with the corresponding symbol
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$dollarSign $_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            MoneyTextFormField(
                settings: MoneyTextFormFieldSettings(controller: moneyController)),
            new Container(
                alignment: Alignment.center,
                padding:
                    new EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Select a currency"),
                    SizedBox(height: 20.0),
                    DropdownButton(
                      value: _selectedLang,
                      items: _dropdownMenuItems,
                      onChanged: onChangeDropdownItem,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Selected : ${_selectedLang.name}'),


                  ],
                )),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => MyNumPadPage(title: 'Add New Item',)),
//      );
//        },
//        tooltip: 'Calculate',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
