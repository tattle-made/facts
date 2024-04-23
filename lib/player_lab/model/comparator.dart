import 'package:image_compare/image_compare.dart';

class Comparator {
  double match;
  Algorithm matchAlgorithm;
  double threshold;

  Comparator(
      {required this.matchAlgorithm, this.match = 0.40, this.threshold = 0.01});
}
