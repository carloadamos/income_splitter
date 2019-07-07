import 'package:flutter/material.dart';
import 'package:income_splitter/models/categorylist.dart';
import 'package:intl/intl.dart';

class CalculatePage extends StatelessWidget {
  final double amountToCalculate;
  CalculatePage({this.amountToCalculate});

  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF2323E2);
    final whiteColor = const Color(0xFFF5F6FA);
    final currencySymbol = NumberFormat().simpleCurrencySymbol('PHP');
    final formatCurrency = NumberFormat.currency(symbol: currencySymbol);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        leading: Container(),
      ),
      body: Container(
        color: blueColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Your Income'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  Text(
                    formatCurrency.format(amountToCalculate),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                ],
              ),
            ),
            // Bottom
            Container(
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                ),
                color: whiteColor,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Breakdown',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return buildBreakDownList(
                            categories[index].categoryPercent,
                            categories[index].categoryName,
                            amountToCalculate);
                      },
                    )),
                  ),
                ],
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Text(
                        'Done',
                        style: TextStyle(color: whiteColor, fontSize: 18.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildBreakDownList(
      double percentage, String title, double totalAmount) {
    String itemTitle = title.toUpperCase();
    double budgetAmount = totalAmount * (percentage / 100);
    final percentFormatter = NumberFormat('#');
    final amountFormatter = NumberFormat('#,###,###.00');

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      child: ListTile(
        leading: Text(
          percentFormatter.format(percentage) + ' %',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        title: Text('$itemTitle'),
        trailing: Text('PHP ' + amountFormatter.format(budgetAmount),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
