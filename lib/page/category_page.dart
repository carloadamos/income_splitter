import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/state/state_container.dart';
import 'package:income_splitter/widgets/percentage_slider.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  CategoryPage({this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController categoryNameController = TextEditingController();
  double initialPercentageValue = 0;

  @override
  initState() {
    categoryNameController.text = widget.category.categoryName;
    initialPercentageValue =
        widget.category.categoryPercent;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _showDialog(
            List<Category> categoryList, selectedCategory) async =>
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Do you want to remove this category?'),
              content: Text('This will remove the category permanently'),
              actions: <Widget>[
                FlatButton(
                  color: Colors.grey,
                  child: Text('Yes'),
                  onPressed: () {
                    categoryList.remove(selectedCategory);
                    Navigator.pop(context, true);
                  },
                ),
                FlatButton(
                  color: Colors.red,
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                )
              ],
            );
          },
        );

    final textFieldColor = const Color(0xFFE6EAFD);

    final categoryList = StateContainer.of(context).categoryList;
    Category selectedCategory = widget.category;

    getAvailablePercentage(List<Category> list) {
      double total = 0.0;
      for (var item in list) {
        if (item != selectedCategory) {
          total += item.categoryPercent;
        }
      }
      return 100 - total;
    }

    double availablePercentage = getAvailablePercentage(categoryList);

    var percentageSlider = PercentageSlider(
        available: availablePercentage,
        initialValue: selectedCategory.categoryPercent,
        category: selectedCategory);

    var categoryNameTextField = CategoryNameTextField(
      category: selectedCategory,
      textFieldColor: textFieldColor,
      categoryNameController: categoryNameController,
    );

    var actionButtons = ActionButtons(
      saveButton: SaveButton(
        initialValue: initialPercentageValue,
        category: selectedCategory,
        textController: categoryNameController,
      ),
      cancelButton: CancelButton(initialValue: initialPercentageValue, selectedCategory: selectedCategory,),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          categoryNameController.text.toUpperCase(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              var categoryList = StateContainer.of(context).categoryList;
              bool removeSelected =
                  await _showDialog(categoryList, widget.category);
              if (removeSelected) {
                Navigator.pop(context);
              }
            },
          ),
        ],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          selectedCategory.categoryPercent = initialPercentageValue;
          Navigator.pop(context);
        }),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      percentageSlider,
                      categoryNameTextField,
                    ],
                  ),
                ),
              ),
              actionButtons
            ],
          ),
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
    @required this.category,
  }) : super(key: key);

  final Color textFieldColor;
  final TextEditingController categoryNameController;
  final Category category;

  @override
  Widget build(BuildContext context) {
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
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          onEditingComplete: () {
            category.categoryName = categoryNameController.text;
            FocusScope.of(context).requestFocus(new FocusNode());
          },
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
      {Key key,
      @required this.category,
      @required this.textController,
      this.initialValue})
      : super(key: key);

  final Category category;
  final TextEditingController textController;
  final double initialValue;

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
          final container = StateContainer.of(context);
          List<Category> modifiedCategories = container.categoryList;

          category.categoryName = textController.text;

          if (category.categoryId == 0) {
            category.categoryId = modifiedCategories.length;
            modifiedCategories.add(category);
          }

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
    this.initialValue,
    this.selectedCategory,
  }) : super(key: key);

  final double initialValue;
  final Category selectedCategory;

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
          selectedCategory.categoryPercent = initialValue;
          Navigator.pop(context);
        },
      ),
    );
  }
}
