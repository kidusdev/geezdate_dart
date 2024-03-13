import 'package:geezdate/geezdate.dart';

void main(List<String> args) {
  final before2Months = GeezDate.now().subtract(months: 2);
  final now = GeezDate.now();
  final after2Months = GeezDate.now().add(months: 2);

  print(before2Months.isFuture);
  print(now.isFuture);
  print(after2Months.isFuture);
}
