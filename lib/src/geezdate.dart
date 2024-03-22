import 'package:jiffy/jiffy.dart';

import 'convert.dart' as convert;
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

  const GeezDate(this.year, this.month, this.date);

  factory GeezDate.now() => convert.toEC(DateTime.now());
  factory GeezDate.fromDateTime(DateTime dateTime) => convert.toEC(dateTime);
  factory GeezDate.fromString(String dateTimeString) => convert.toEC(DateTime.parse(dateTimeString));
  factory GeezDate.fromJson(Map<String, int> json) {
    final now = GeezDate.fromDateTime(DateTime.now());
    return GeezDate(json["year"] ?? now.year, json["month"] ?? now.month, json["date"] ?? now.date);
  }

  @override
  bool operator ==(covariant GeezDate other) => other.year == year && other.month == month && other.date == date;

  //
  DateTime toGC() => convert.toGC(this);

  // formatting
  /// ### formats
  /// * .d - date        => 1 - 30
  /// * .D - day         => ሰንበት - ቐዳም
  /// * .m - month index => 1 - 13
  /// * .M - month name  => መስከረም - ጳጉሜ
  /// * .y - year        => 00
  /// * .Y - year        => 0000
  /// * .E - calender    => ዓ.ም
  String format(String pattern, [FormatLanguage lang = FormatLanguage.amharic]) => formatDate(pattern, this, lang);

  // navigating
  GeezDate add({int days = 1, int weeks = 0, int months = 0, int years = 0}) {
    final newDate =
        Jiffy.parseFromDateTime(toGC()).add(days: days, weeks: weeks, months: months, years: years).dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  GeezDate subtract({int days = 1, int weeks = 0, int months = 0, int years = 0}) {
    final newDate =
        Jiffy.parseFromDateTime(toGC()).subtract(days: days, weeks: weeks, months: months, years: years).dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  // checking
  bool get isToday => Jiffy.parseFromDateTime(toGC()).diff(Jiffy.now(), unit: Unit.day) == 0;
  bool get isFuture => Jiffy.parseFromDateTime(toGC()).diff(Jiffy.now(), unit: Unit.day) > 0;
  bool get isPast => Jiffy.parseFromDateTime(toGC()).diff(Jiffy.now(), unit: Unit.day) < 0;

  bool get isThisMonth => year == GeezDate.now().year && month == GeezDate.now().month;
  bool get isThisyear => year == GeezDate.now().year;

  bool isSameDate(GeezDate date) => year == date.year && month == date.month && this.date == date.date;
  bool isSameDay(GeezDate date) => toGC().weekday == date.toGC().weekday;
  bool isSameMonth(GeezDate date) => year == date.year && month == date.month;
  bool isSameYear(GeezDate date) => year == date.year;

  @override
  String toString() => "GeezDate ({ year: $year, month: $month, date: $date })";
  @override
  int get hashCode => int.parse("$year$month$date");
}
