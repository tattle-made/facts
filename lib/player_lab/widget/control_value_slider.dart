import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/layer_config.dart';

class ControlValueSlider extends StatefulWidget {
  ControlValueDoubleRange controlValue;
  Function? onChange;
  ControlValueSlider(
      {super.key, required this.controlValue, required this.onChange});

  @override
  State<ControlValueSlider> createState() => _ControlValueSliderState();
}

class _ControlValueSliderState extends State<ControlValueSlider> {
  late double value;

  @override
  void initState() {
    setState(() {
      value = widget.controlValue.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 75,
          child: Column(
            children: [
              Text(
                "${widget.controlValue.label}",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              // Text("${widget.controlValue.value.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontSize: 10),)
            ],
          ),
        ),
        Slider(
            value: value,
            min: widget.controlValue.min,
            max: widget.controlValue.max,
            onChanged: (val) {
              if (widget.controlValue.isValid(val)) {
                widget.controlValue.value = val;
                setState(() {
                  value = val;
                });
                widget.onChange!();
              }
            }),
      ],
    );
  }
}
