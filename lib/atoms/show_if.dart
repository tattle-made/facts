import 'package:facts/atoms/heading.dart';
import 'package:flutter/widgets.dart';

Widget ShowIf({condition, child}) {
  return condition ? child : Container();
}
