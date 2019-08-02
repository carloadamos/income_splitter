class Currency {
  String symbol;
  String name;
  String symbolNative;
  int decimal;
  int rounding;
  String code;
  String namePlurarl;

  Currency({this.symbol, this.name, this.code});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      Currency(symbol: json['symbol'], name: json['name'], code: json['code']);
}

class CurrencyList {
  final List<Currency> currencies;

  CurrencyList({this.currencies});

  factory CurrencyList.fromJson(Map<String, dynamic> parsedJson) {
    List<Currency> currencyList = [];
    currencyList = parsedJson.values.map((i) => Currency.fromJson(i)).toList();
    return CurrencyList(currencies: currencyList);
  }
}
