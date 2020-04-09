import 'package:flutter/material.dart';

import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:moneytextformfield/moneytextformfield.dart';

//import 'lib/second_page.dart' as route;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bread Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Bread Converter'),
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
      Language(6, 'CAD (\$)'),
      Language(7, 'MEX (\$)'),
    ];
  }
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterMoneyFormatter fmf;
  double doubleValue;
  String defaultValue = '0';

  String dollarSign = '\$';
  TextEditingController moneyController =
      TextEditingController(); //for money format
  List<Language> _languages = Language.getMoneyLanguage();
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  Language _selectedLang;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(_languages);
    _selectedLang = _dropdownMenuItems[0].value;

//    super.initState();
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
    if (mounted) {
      setState(() {
        _selectedLang = selectedLanguage;
        print(selectedLanguage.name);
        if (selectedLanguage.name == 'JPY (¥)') {
          dollarSign = 'Japanese Yen ¥';
        } else if (selectedLanguage.name == 'EUR (€)') {
          dollarSign = 'Euro €';
        } else if (selectedLanguage.name == 'GBP (£)') {
          dollarSign = 'Pound £';
        } else if (selectedLanguage.name == 'AUD (\$)') {
          dollarSign = 'Australian \$';
        } else if (selectedLanguage.name == 'CAD (\$)') {
          dollarSign = 'Canadian \$';
        } else if (selectedLanguage.name == 'USD (\$)') {
          dollarSign = 'United States \$';
        }
      });
    }
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
              defaultValue,
              style: Theme.of(context).textTheme.display2,
            ),
            MoneyTextFormField(
              settings: MoneyTextFormFieldSettings(
                controller: moneyController,
              ),
            ),
            RaisedButton(
              child: Text('Translate'),
              onPressed: () {
                doSomething(moneyController.text);
              },
            ),
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
    );
  }

  doSomething(String text) {
    setState(() {
      doubleValue = double.parse(moneyController.text);

      if (dollarSign == 'Japanese Yen ¥') {
        doubleValue = 108.94500 * doubleValue;
      } else if (dollarSign == 'Euro €') {
        doubleValue = 0.92175 * doubleValue;
      } else if (dollarSign == 'Pound £') {
        doubleValue = 0.80785 * doubleValue;
      } else if (dollarSign == 'Canadian \$') {
        doubleValue = 1.40290 * doubleValue;
      } else if (dollarSign == 'Australian \$') {
        doubleValue = 1.60604 * doubleValue;
      } else if (dollarSign == 'United States \$') {
        doubleValue = 1 * doubleValue;
      }

      fmf = FlutterMoneyFormatter(amount: doubleValue);

      print(fmf.output.nonSymbol);

      String StringOfFormattedMoney = fmf.output.nonSymbol.toString();

      defaultValue = StringOfFormattedMoney;
//      text = moneyController.text;
//      defaultValue = text;
    });
  }
}
