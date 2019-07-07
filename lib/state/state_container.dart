import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/models/categorylist.dart';

class StateContainer extends StatefulWidget {
  final Widget child;
  final List<Category> categories;

  StateContainer({@required this.child, this.categories});

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

  void updateCategoryList(updatedCategoryList) {
    setState(() {
      categoryList = updatedCategoryList;
      categories = categoryList;
    });
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
