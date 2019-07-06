import 'package:flutter/material.dart';
import 'package:income_splitter/models/categorylist.dart';
import 'package:income_splitter/state_container.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF2323E2);
    final whiteColor = const Color(0xFFF5F6FA);
    final textFieldColor = const Color(0xFFE6EAFD);

    TextEditingController incomeController = TextEditingController();

    final container = StateContainer.of(context);
    container.categoryList = categories;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, 'categories');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'How much is your income?',
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
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
            ),
            RaisedButton(
              color: blueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Text(
                  'Calculate',
                  style: TextStyle(color: whiteColor, fontSize: 18.0),
                ),
              ),
              onPressed: () {
                final container = StateContainer.of(context);
                container.updateIncomeAmount(double.parse(incomeController.text));
                Navigator.pushNamed(context, 'calculate');
              },
            ),
          ],
        ),
      ),
    );
  }
}
