import 'package:geezdate/geezdate.dart';

void main() {
  for (var i = 0; i < 24; i++) {
    print(GeezDate.fromDateTime(DateTime(2024, 5, 28, i)));
  }
}
