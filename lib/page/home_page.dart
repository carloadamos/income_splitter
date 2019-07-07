import 'package:flutter/material.dart';
import 'package:income_splitter/models/categorylist.dart';
import 'package:income_splitter/page/calculate_page.dart';
import 'package:income_splitter/state/state_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textFieldColor = const Color(0xFFE6EAFD);
    TextEditingController incomeController = TextEditingController();
    final container = StateContainer.of(context);
    container.categoryList = categories;

    var settingsButton = IconButton(
      icon: Icon(Icons.settings, color: Colors.black),
      onPressed: () {
        Navigator.pushNamed(context, 'categories');
      },
    );

    var appBar = AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0.0,
      actions: <Widget>[settingsButton],
    );

    var questionText = Text(
      'How much is your income?',
      style: TextStyle(fontSize: 24.0),
    );
    var incomeInputField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: textFieldColor,
        ),
        width: 250.0,
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: incomeController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );

    var calculateButton = RaisedButton(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          'Calculate',
          style:
              TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'calculate',
            arguments: CalculatePage(
              amountToCalculate: double.parse(incomeController.text),
            ));
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            questionText,
            incomeInputField,
            calculateButton,
          ],
        ),
      ),
    );
  }
}
