import 'dart:convert';
import 'dart:io';

import 'package:geezdate/geezdate.dart';

void main(List<String> args) {
  final str = jsonDecode(File("./items.json").readAsStringSync());

  for (var i in str) {
    final date = GeezDate.fromDateTime(DateTime.parse(i["created_at"]));

    final formatted = (date.toFormatted(".M/.Y"));
    print(formatted);
  }
}
