import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';

class PercentageSlider extends StatefulWidget {
  const PercentageSlider({Key key, this.initialValue, this.category})
      : super(key: key);

  final double initialValue;
  final Category category;

  @override
  _PercentageSliderState createState() => _PercentageSliderState();
}

class _PercentageSliderState extends State<PercentageSlider> {
  double _value = 0.0;
  String _textValue = "title";

  double get value {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    _value = _value == 0.0 ? widget.initialValue : _value;
    _textValue = _value.round().toString();

    showPercentDialog(double percent) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You can only assign $percent % maximum'),
            content: Text('You can only assign $percent % maximum'),
            actions: <Widget>[
              FlatButton(
                child: Text('WTF'),
                onPressed: () {},
              )
            ],
          );
        },
      );
    }

    ;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            '$_textValue' + " %",
            style: TextStyle(fontSize: 54.0),
          ),
          Slider(
            value: _value,
            min: 0,
            max: 100,
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            onChanged: (double updatedValue) {
              setState(
                () {
                  _textValue = updatedValue.round().toString();
                  if ((double.parse(_textValue) <=
                      widget.category.categoryPercent)) {
                    _value = updatedValue;
                    widget.category.categoryPercent = _value;
                  }
                 else{
                    showPercentDialog(widget.category.categoryPercent);
                 }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
