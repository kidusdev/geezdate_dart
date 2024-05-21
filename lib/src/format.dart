import 'package:geezdate/src/enums.dart';

import 'constants.dart';
import '../../../src/geezdate.dart';

String formatDate(
  String pattern,
  GeezDate geezdate, [
  FormatLanguage formatLanguage = FormatLanguage.am,
  FormatLength formatLength = FormatLength.short,
]) {
  final GeezDate(:year, :month, :date, :hour, :minute, :second) = geezdate;
  final days = switch (formatLength) {
    FormatLength.short => getLanguages(formatLanguage).daysInShorts,
    FormatLength.long => getLanguages(formatLanguage).days,
  };
  final months = switch (formatLength) {
    FormatLength.short => getLanguages(formatLanguage).monthsInShorts,
    FormatLength.long => getLanguages(formatLanguage).months,
  };

  if (pattern.isEmpty) throw "pattern is empty!";
  if (date < 1 || date > 30) throw "incorrect date! needed 0 - 30, given $date";
  if (month < 1 || month > 13) throw "incorrect month! needed 1 - 13, given $month";

  final gcDate = geezdate.toGC();

  return pattern

      // time
      .replaceAll(RegExp(r"\.s"), "${second < 10 ? "0$second" : second}")
      .replaceAll(RegExp(r"\.mn"), "${minute < 10 ? "0$minute" : minute}")
      .replaceAll(RegExp(r"\.h"), "${hour < 10 ? "0$hour" : hour}")

      // days
      .replaceAll(RegExp(r"\.d"), "${date < 10 ? "0$date" : date}")
      .replaceAll(RegExp(r"\.D"), days[gcDate.weekday - 1])

      // months
      .replaceAll(RegExp(r"\.m"), "${month < 10 ? "0$month" : month}")
      .replaceAll(RegExp(r"\.M"), months[month - 1])

      // years
      .replaceAll(RegExp(r"\.y+"), "${2016 % 100}")
      .replaceAll(RegExp(r"\.Y"), "$year")

      // EC
      .replaceAll(RegExp(r"\.[Ee]+"), "ዓ.ም");
}
