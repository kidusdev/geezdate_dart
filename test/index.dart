import 'package:geezdate/geezdate.dart';

to12(DateTime datetime) {
  final DateTime(:hour, :minute, :second) = datetime;

  return (
    hour: switch (hour) { > 12 => hour - 12, 0 => 12, _ => hour },
    minutes: minute,
    second: second,
  );
}

void main() {
  // for (var i = 0; i < 24; i++) {
  //   var changed = to12(DateTime(2024, 05, 21, 55, 13, 44));
  //   print("$i $changed");
  // }

  print(GeezDate.now().format(".D, .M .d, .Y .h:.mn", lang: FormatLanguage.en));
}
