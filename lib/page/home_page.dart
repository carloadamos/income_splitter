import 'package:flutter/material.dart';
import 'package:income_splitter/database_helper.dart';
import 'package:income_splitter/models/categorylist.dart';
import 'package:income_splitter/page/calculate_page.dart';
import 'package:income_splitter/state/state_container.dart';
import 'package:simple_permissions/simple_permissions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _allowWriteFile = false;

  @override
  void initState() {
    requestWritePermission();
    super.initState();
  }

  requestWritePermission() async {
    Permission permission;
    bool permissionStatus = await SimplePermissions.checkPermission(permission);
    
    if (permissionStatus) {
      setState(
        () {
          _allowWriteFile = true;
        },
      );
    }
    else
    {
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFieldColor = const Color(0xFFE6EAFD);
    TextEditingController incomeController = TextEditingController();
    final container = StateContainer.of(context);

    var popup = PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.black,),
      onSelected: (String value) {
        if (value == 'Categories'){
          Navigator.pushNamed(context, 'categories');
        }
        else
        {
          Navigator.pushNamed(context, 'currency');
        }

      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Categories',
              child: Text('Categories'),
            ),
            const PopupMenuItem<String>(
              value: 'Currency',
              child: Text('Currency'),
            ),
          ],
    );

    var appBar = AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0.0,
      actions: <Widget>[popup],
    );

    var questionText = Text(
      'How much is your income?',
      style: TextStyle(fontSize: 24.0),
    );
    var incomeInputField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: textFieldColor,
        ),
        width: 250.0,
        child: TextFormField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: incomeController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );

    var calculateButton = RaisedButton(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          'Calculate',
          style:
              TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'calculate',
            arguments: CalculatePage(
              amountToCalculate: double.parse(incomeController.text),
            ));
      },
    );

    Future<void> getData() async {
      final list = await DBProvider.db.getAllCategory();
      if (list.length != 0) {
        container.categoryList = list;
      } else {
        container.categoryList = categories;
      }
    }

    if (_allowWriteFile) {
      getData();
    }

    var noPermission = Center(
      child: Text('Permission denied'),
    );

    var withPermission = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          questionText,
          incomeInputField,
          calculateButton,
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: appBar,
        body: _allowWriteFile ? withPermission : noPermission);
  }
}
