import 'dart:ui';

class LayerConfig{
  late List<ControlValueType> controls;
}

abstract class ControlValueType<T> {
  String get label;
  set label (String label);
  T get value;
  set value (T val);
  bool isValid(T val);
}

class ControlValueBoolean extends ControlValueType<bool>{
  @override
  bool value;
  @override
  String label;

  ControlValueBoolean({required this.value, required this.label});

  @override
  bool isValid(bool val){
    if(val==true||val==false){
      return true;
    }else{
      return false;
    }
  }

  @override
  String toString(){
    return "ControlValueBoolean ($value)";
  }
}

class ControlValueIntRange extends ControlValueType<int>{
  late int min;
  late int max;

  @override
  int value;
  @override
  String label;

  ControlValueIntRange({required this.value, required this.label, required this.min, required this.max});

  @override
  bool isValid(int val){
    if(val>min && val<max){
      return true;
    }else{
      return false;
    }
  }

  @override
  String toString(){
    return "ControlValueIntRange ($value, max:$max, min:$min)";
  }
}

class ControlValueDoubleRange extends ControlValueType<double>{
  late double min;
  late double max;

  @override
  double value;
  @override
  String label;

  ControlValueDoubleRange({required this.value, required this.label, required this.min, required this.max});

  @override
  bool isValid(double val){
    if(val>min && val<max){
      return true;
    }else{
      return false;
    }
  }

  @override
  String toString(){
    return "ControlValueDoubleRange ($value, max:$max, min:$min)";
  }
}

class ControlValueColorBrush extends ControlValueType<Color>{
  @override
  String label;

  @override
  Color value;

  ControlValueColorBrush({required this.value, required this.label});

  @override
  bool isValid(Color val) {
    return true;
  }

  @override
  String toString(){
    return "ControlValueBrush ($value)";
  }
}

class ControlValueChoices extends ControlValueType<String>{
  late List<String> choices;
  @override
  String value;
  @override
  String label;

  ControlValueChoices({required this.value, required this.label, required this.choices});

  @override
  bool isValid(String val) {
    for(var i=0;i<choices.length;i++){
      if(choices[i]==val){
        return true;
      }
    }
    return false;
  }

  @override
  String toString(){
    return "ControlValueChoices ($value, choices:${choices.join(",")})";
  }
}

