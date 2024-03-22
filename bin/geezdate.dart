import 'package:geezdate/geezdate.dart';
import 'dart:collection' as col;

void main(List<String> args) {
  final grouped = [];
  final ls = List.generate(200, (index) => GeezDate.now().add(days: index).format(".d .M .Y"));

  print(ls.join("\n"));
}
