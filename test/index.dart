import 'package:geezdate/geezdate.dart';
import 'package:geezdate/src/compare.dart';

void main() {
  final date = GeezDate(2016, 11, 11);
  final start = GeezDate(2016, 10, 12);
  final end = GeezDate(2017, 12, 15);

  print(date.isBetween(start, end));
}
