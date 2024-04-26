import 'package:geezdate/geezdate.dart';

void main() {
  final one = GeezDate.now();
  final two = one + 1.years + 2.months + 10.days;

  print(two);
}
