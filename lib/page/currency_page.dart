import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:income_splitter/models/currency.dart';

import 'package:flutter/material.dart';
import 'package:income_splitter/models/currency_services.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {


  @override
  Widget build(BuildContext context) {
    loadCurrency();
    List<Currency> currencies = [];
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('Currency'),
      ),
    );
  }

  Future<String> _loadCurrencyAsset() async {
    return await rootBundle.loadString('assets/currency.json');
  }

  Future<void> loadCurrency() async {
    String jsonString = await _loadCurrencyAsset();
    final response = json.decode(jsonString);
    CurrencyList currencyList = CurrencyList.fromJson(response);
    currencies = currencyList.currencies;
  }
}
