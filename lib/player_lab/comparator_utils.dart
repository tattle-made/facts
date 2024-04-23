import 'dart:ui';

bool isAround(Offset target, Offset current, double threshold) {
  var distance = (target - current).distance;
  print("DISTANCE : $distance");
  var result = distance < threshold ? true : false;
  return result;
}
