import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/state_container.dart';
import 'package:income_splitter/widgets/percentage_slider.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  CategoryPage({this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    bool newCategory = widget.category.categoryId == 0 ? true : false;

    String title = newCategory ? 'New Category' : widget.category.categoryName;

    var categoryNameController = TextEditingController();
    categoryNameController.text = title.toUpperCase();

    // Color
    final textFieldColor = const Color(0xFFE6EAFD);

    Category selectedCategory = widget.category;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('$title'.toUpperCase()),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    PercentageSlider(
                        initialValue: selectedCategory.categoryPercent,
                        category: selectedCategory),
                    new CategoryNameTextField(
                      textFieldColor: textFieldColor,
                      categoryNameController: categoryNameController,
                    ),
                  ],
                ),
              ),
            ),
            new ActionButtons(
              saveButton: SaveButton(
                category: selectedCategory,
                textController: categoryNameController,
              ),
              cancelButton: CancelButton(),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryNameTextField extends StatelessWidget {
  const CategoryNameTextField({
    Key key,
    @required this.textFieldColor,
    @required this.categoryNameController,
  }) : super(key: key);

  final Color textFieldColor;
  final TextEditingController categoryNameController;

  @override
  Widget build(BuildContext context) {
    final stateContainer = StateContainer.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: textFieldColor,
        ),
        width: 250.0,
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: categoryNameController,
          onSaved: (context) =>
              stateContainer.title = categoryNameController.text,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    Key key,
    @required this.saveButton,
    @required this.cancelButton,
  }) : super(key: key);

  final Widget saveButton;
  final Widget cancelButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            saveButton,
            SizedBox(
              height: 5.0,
            ),
            cancelButton,
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton(
      {Key key, @required this.category, @required this.textController})
      : super(key: key);

  final Category category;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Text(
            'Save',
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0),
          ),
        ),
        onPressed: () {
          List<Category> modifiedCategories =
              StateContainer.of(context).categoryList;
          final container = StateContainer.of(context);
          container.title = textController.text;
          container.category.categoryName = container.title;
          container.updateCategoryList(modifiedCategories);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF9D9EA4), fontSize: 18.0),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
