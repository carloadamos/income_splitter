
import 'package:flutter/material.dart';
import 'package:income_splitter/models/category.dart';
import 'package:income_splitter/state_container.dart';

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
    final container = StateContainer.of(context);

    return Column(
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
            setState(() {
              _value = updatedValue;
              _textValue = _value.round().toString();
              widget.category.categoryPercent = double.parse(_textValue);
            });
          },
        ),
      ],
    );
  }
}