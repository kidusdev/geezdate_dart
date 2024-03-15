import 'package:jiffy/jiffy.dart';

import 'convert.dart';
import 'format.dart';

extension DateTimeGeezDateExtension on DateTime {
  GeezDate toEC() {
    return GeezDate.fromDateTime(this);
  }
}

class GeezDate {
  final int year;
  final int month;
  final int date;

  GeezDate(this.year, this.month, this.date);

  factory GeezDate.now() => toEC(DateTime.now());
  factory GeezDate.fromDateTime(DateTime dateTime) => toEC(dateTime);
  factory GeezDate.fromString(String dateTimeString) => toEC(DateTime.parse(dateTimeString));
  factory GeezDate.fromJson(Map<String, int> json) {
    final now = GeezDate.fromDateTime(DateTime.now());
    return GeezDate(json["year"] ?? now.year, json["month"] ?? now.month, json["date"] ?? now.date);
  }

  DateTime toGc() => toGC(this);

  // formatting
  /// ### formats
  /// * .d - date        => 1 - 30
  /// * .D - day         => ሰንበት - ቐዳም
  /// * .m - month index => 1 - 13
  /// * .M - month name  => መስከረም - ጳጉሜ
  /// * .y - year        => 00
  /// * .Y - year        => 0000
  /// * .E - calender    => ዓ.ም
  String toFormatted(String pattern, [FormatLanguage lang = FormatLanguage.amharic]) => format(pattern, this, lang);

  // navigating
  GeezDate add({int days = 1, int weeks = 0, int months = 0, int years = 0}) {
    final newDate =
        Jiffy.parseFromDateTime(toGc()).add(days: days, weeks: weeks, months: months, years: years).dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  GeezDate subtract({int days = 1, int weeks = 0, int months = 0, int years = 0}) {
    final newDate =
        Jiffy.parseFromDateTime(toGc()).subtract(days: days, weeks: weeks, months: months, years: years).dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  // checking
  bool get isToday => Jiffy.parseFromDateTime(toGc()).diff(Jiffy.now(), unit: Unit.day) == 0;
  bool get isFuture => Jiffy.parseFromDateTime(toGc()).diff(Jiffy.now(), unit: Unit.day) > 0;
  bool get isPast => Jiffy.parseFromDateTime(toGc()).diff(Jiffy.now(), unit: Unit.day) < 0;

  @override
  String toString() => "GeezDate ({ year: $year, month: $month, date: $date })";
}
