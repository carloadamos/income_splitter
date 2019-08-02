import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:income_splitter/models/currency.dart';

List<Currency> currencies = [];

Future<String> _loadCurrencyAsset() async{
  return await rootBundle.loadString('lib/models/currency.json');
}

Future loadCurrency() async {
 String jsonString = await _loadCurrencyAsset();
final response = json.decode(jsonString);
Currency currency = Currency.fromJson(response);

}
