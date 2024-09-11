import 'package:geezdate/src/enums.dart';
import 'package:jiffy/jiffy.dart';

import 'constants.dart';
import '../../../src/geezdate.dart';

String formatDate(
  String pattern,
  GeezDate geezdate, [
  FormatLanguage formatLanguage = FormatLanguage.ti,
  FormatLength formatLength = FormatLength.long,
]) {
  final GeezDate(:year, :month, :date, :hour, :minute, :second, :shift) = geezdate;
  final days = switch (formatLength) {
    FormatLength.short => getLanguages(formatLanguage).daysInShorts,
    FormatLength.long => getLanguages(formatLanguage).days,
  };
  final months = switch (formatLength) {
    FormatLength.short => getLanguages(formatLanguage).monthsInShorts,
    FormatLength.long => getLanguages(formatLanguage).months,
  };
  final shifts = getLanguages(formatLanguage).shifts;

  if (pattern.isEmpty) throw "pattern is empty!";
  if (date < 1 || date > 30) throw "incorrect date! needed 0 - 30, given $date";
  if (month < 1 || month > 13) throw "incorrect month! needed 1 - 13, given $month";

  final gcDate = geezdate.toGC();

  return pattern

      // time
      .replaceAll(RegExp(r"\.sh"), shift == Shift.day ? shifts.am : shifts.pm)
      .replaceAll(RegExp(r"\.s"), add0(second))
      .replaceAll(RegExp(r"\.mn"), add0(minute))
      .replaceAll(RegExp(r"\.h"), add0(hour))

      // days
      .replaceAll(RegExp(r"\.d"), add0(date))
      .replaceAll(RegExp(r"\.D"), days[gcDate.weekday - 1])

      // months
      .replaceAll(RegExp(r"\.m"), add0(month))
      .replaceAll(RegExp(r"\.M"), months[month - 1])

      // years
      .replaceAll(RegExp(r"\.y+"), "${year % 100}")
      .replaceAll(RegExp(r"\.Y"), "$year")

      // EC
      .replaceAll(RegExp(r"\.[Ee]+"), "ዓ.ም");
}

String formatGCDate(
  DateTime datetime,
  String pattern, [
  FormatLanguage formatLanguage = FormatLanguage.en,
  FormatLength formatLength = FormatLength.long,
]) {
  final DateTime(:year, :month, :day, :hour, :minute, :second, :weekday) = datetime;
  print(Jiffy.now().hour);
  final days = switch (formatLength) {
    FormatLength.short => getLanguages(formatLanguage).daysInShorts,
    FormatLength.long => getLanguages(formatLanguage).days,
  };
  final months = switch (formatLength) {
    FormatLength.short => orderMonthsForGC(getLanguages(formatLanguage).monthsInShorts),
    FormatLength.long => orderMonthsForGC(getLanguages(formatLanguage).months),
  };

  if (pattern.isEmpty) throw "pattern is empty!";

  return pattern

      // time
      .replaceAll(RegExp(r"\.s"), add0(second))
      .replaceAll(RegExp(r"\.mn"), add0(minute))
      .replaceAll(RegExp(r"\.h"), add0(hour))

      // days
      .replaceAll(RegExp(r"\.d"), add0(day))
      .replaceAll(RegExp(r"\.D"), days[weekday - 1])

      // months
      .replaceAll(RegExp(r"\.m"), add0(month))
      .replaceAll(RegExp(r"\.M"), months[month - 1])

      // years
      .replaceAll(RegExp(r"\.y+"), "${year % 100}")
      .replaceAll(RegExp(r"\.Y"), "$year")

      // EC
      .replaceAll(RegExp(r"\.[Ee]+"), "EC");
}

String add0(num number) => "${number < 10 ? "0$number" : number}";
