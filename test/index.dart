import 'package:geezdate/geezdate.dart';
import 'package:geezdate/src/compare.dart';

void main() {
  final date = GeezDate.now();

  print(date.format(".h:.mn .sh", lang: FormatLanguage.en));
}
