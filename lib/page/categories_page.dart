import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/page/category_page.dart';
import 'package:income_splitter/state_container.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF2323E2);
    final whiteColor = const Color(0xFFF5F6FA);
    final categoryList = StateContainer.of(context).categoryList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return buildContainerItem(categoryList[index], context);
          },
        ),
      ),
      floatingActionButton: buildFloatingActionButton(whiteColor, context),
    );
  }

  Padding buildContainerItem(Category category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0),
        child: RaisedButton(
          elevation: 5,
          color: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Text(
                    category.categoryName.toUpperCase(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(category.categoryPercent.toString(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              'category',
              arguments: CategoryPage(
                category: category,
              ),
            );
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Category(newCategory: false,)));
          },
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(
      Color whiteColor, BuildContext context) {
    return FloatingActionButton(
      backgroundColor: whiteColor,
      child: Icon(
        Icons.add,
        color: Color(0xFF000000),
      ),
      onPressed: () {
        Category newCategory = Category(
            categoryId: 0, categoryName: 'New Category', categoryPercent: 0);

        Navigator.pushNamed(context, 'category',
            arguments: CategoryPage(
              category: newCategory,
            ));
      },
    );
  }
}
