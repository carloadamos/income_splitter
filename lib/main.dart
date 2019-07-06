import 'package:flutter/material.dart';
import 'package:income_splitter/page/calculate_page.dart';
import 'package:income_splitter/page/categories_page.dart';
import 'package:income_splitter/page/category_page.dart';
import 'package:income_splitter/page/home_page.dart';
import 'package:income_splitter/state_container.dart';

void main() {
  runApp(
    StateContainer(
      child: IncomeSplitter(),
    ),
  );
}

class IncomeSplitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF2323E2),
        accentColor: Color(0xFFF5F6FA),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: _getRoute,
      routes: {
        '/': (context) => HomePage(),
        'calculate': (context) => CalculatePage(),
        'categories': (context) => CategoriesPage(),
      },
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name == 'category') {
    return _buildRoute(
      settings,
    );
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings) {
  final CategoryPage category = settings.arguments;

  return MaterialPageRoute(
    builder: (context) {
      return category;
    },
  );
}
