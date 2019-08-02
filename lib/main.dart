import 'package:flutter/material.dart';
import 'package:income_splitter/page/calculate_page.dart';
import 'package:income_splitter/page/categories_page.dart';
import 'package:income_splitter/page/category_page.dart';
import 'package:income_splitter/page/currency_page.dart';
import 'package:income_splitter/page/home_page.dart';
import 'package:income_splitter/state/state_container.dart';

void main() {
  runApp(
    StateContainer(
      child: IncomeSplitter(),
    ),
  );
}

/// Goals
/// 1. Create the UI according to design -- done
/// 2. Add functionalities like add, edit, delete -- done
/// 3. Put validation on 100% - done?
/// 4. Save the final state of the categories locally - in progress
/// 5. Use firebase for saving
class IncomeSplitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
        brightness: Brightness.light,
        primaryColor: Color(0xFF2323E2),
        accentColor: Color(0xFFF5F6FA),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: _getRoute,
      routes: {
        '/': (context) => HomePage(),
        'categories': (context) => CategoriesPage(),
        'currency': (context) => CurrencyPage(),
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
  if (settings.name == 'calculate') {
    return _buildRoute(
      settings,
    );
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      if (settings.name == 'category') {
        final CategoryPage categoryPage = settings.arguments;
        return categoryPage;
      }
      if (settings.name == 'calculate') {
        final CalculatePage calculatePage = settings.arguments;
        return calculatePage;
      }
    },
  );
}
