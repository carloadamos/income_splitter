import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';

class PercentageSlider extends StatefulWidget {
  const PercentageSlider(
      {Key key, this.initialValue, this.category, this.available})
      : super(key: key);

  final double available;
  final double initialValue;
  final Category category;

  @override
  _PercentageSliderState createState() => _PercentageSliderState();
}

class _PercentageSliderState extends State<PercentageSlider> {
  double _value = 0.0;
  String _textValue = "title";
  double _available = 0.0;

  double get value {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    _available = widget.available;
    _value = _value == 0.0 ? widget.initialValue : _value;
    _textValue = _value.round().toString();

    showPercentDialog(double percent) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String percentText = percent.round().toString();
          return AlertDialog(
            title: Text('You can only assign $percentText% at maximum'),
            content: Text('Review your categories and free up some allocation to set this.'),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            '$_textValue' + " %",
            style: TextStyle(fontSize: 54.0),
          ),
          Slider(
            value: _value.round().toDouble(),
            min: 0,
            max: _available.round().toDouble(),
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            onChanged: (double updatedValue) {
              setState(
                () {
                  _textValue = updatedValue.round().toString();
                  if ((double.parse(_textValue) <= _available)) {
                    _value = updatedValue;
                    widget.category.categoryPercent = _value;
                  } else {
                    showPercentDialog(_available);
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
