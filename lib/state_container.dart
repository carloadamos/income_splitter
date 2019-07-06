import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/models/categorylist.dart';

class StateContainer extends StatefulWidget {
  final Widget child;
  final List<Category> categories;
  final double incomeAmount;
  final Category category;

  StateContainer(
      {@required this.child,
      this.categories,
      this.incomeAmount,
      this.category});

  static _StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedStateContainer)
            as InheritedStateContainer)
        .data;
  }

  @override
  _StateContainerState createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  List<Category> categoryList;
  Category category;
  double income;
  String title;

  void updateCategoryList(updatedCategoryList) {
    setState(() {
      categoryList = updatedCategoryList;
      categories = categoryList;
    });
  }

  void updateIncomeAmount(incomeToDivide) {
    income = incomeToDivide;
  }

  void updateSelectedCategory(updatedCategory) {
    category = updatedCategory;
  }

  void setCategoryTitle(newTitle) {
    title = newTitle;
  }

  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class InheritedStateContainer extends InheritedWidget {
  final _StateContainerState data;

  InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
