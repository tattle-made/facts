import 'package:facts/player_lab/model/layer_config.dart';
import 'package:facts/player_lab/widget/control_value_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayerControls extends StatefulWidget {
  late List<ControlValueType> controls;
  Function? onChange;

  LayerControls({super.key, required this.controls, required this.onChange});

  @override
  State<LayerControls> createState() => _LayerControlsState();
}

class _LayerControlsState extends State<LayerControls> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children:[
          for(var control in widget.controls) LayerControlWidget(control: control, onChange: widget.onChange)
      ]),
    );
  }
}

class LayerControlWidget extends StatelessWidget {
  late ControlValueType control;
  Function? onChange;

  LayerControlWidget({super.key, required this.control, required this.onChange});

  @override
  Widget build(BuildContext context) {
    if(control != null){
      switch(control.runtimeType){
        case ControlValueBoolean:
          return Text("control value boolean");
        case ControlValueIntRange:
          return Text("control value int range");
        case ControlValueDoubleRange:
          return Container(
            child: ControlValueSlider(controlValue: control as ControlValueDoubleRange, onChange:onChange)
          );
        default:
          return Text("default case");
      }
    }else return Text("no control defined");
  }
}
