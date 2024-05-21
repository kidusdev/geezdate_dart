import 'package:geezdate/src/compare.dart' as cmp;
import 'package:geezdate/src/enums.dart';
import 'package:jiffy/jiffy.dart';

import 'convert.dart' as convert;
import 'format.dart';

class GeezDate {
  final int year;
  final int month;
  final int date;
  final int hour;
  final int minute;
  final int second;

  const GeezDate(this.year, this.month, this.date, [this.hour = 1, this.minute = 0, this.second = 0]);

  // constructors
  factory GeezDate.now() => convert.toEC(DateTime.now());
  factory GeezDate.fromDateTime(DateTime dateTime) => convert.toEC(dateTime);
  factory GeezDate.fromString(String dateTimeString) => convert.toEC(DateTime.parse(dateTimeString));
  factory GeezDate.fromJson(Map<String, int> json) {
    final now = GeezDate.fromDateTime(DateTime.now());
    return GeezDate(
      json["year"] ?? now.year,
      json["month"] ?? now.month,
      json["date"] ?? now.date,
      json["hour"] ?? now.hour,
      json["minute"] ?? now.minute,
      json["second"] ?? now.second,
    );
  }
  // converters
  DateTime toGC() => convert.toGC(this);

  // operators
  @override
  bool operator ==(covariant GeezDate other) => cmp.isSameDate(this, other);
  GeezDate operator +(covariant int seconds) => add(seconds: seconds);
  GeezDate operator -(covariant int seconds) => subtract(seconds: seconds);
  bool operator >(covariant GeezDate other) => cmp.compare(this, other, CompareDatesResultUnit.day) > 0;
  bool operator <(covariant GeezDate other) => cmp.compare(this, other, CompareDatesResultUnit.day) < 0;

  // formatting
  /// ## formats
  ///
  /// -----------------------------------------
  /// * **Date**
  ///   * .d - date        => 1 - 30
  ///   * .D - day         => ሰኞ - እሁድ
  /// -----------------------------------------
  /// * **Month**
  ///   * .m - month index => 1 - 13
  ///   * .M - month name  => መስከረም - ጳጉሜ
  /// -----------------------------------------
  /// * **Year**
  ///   * .y - year        => 00
  ///   * .Y - year        => 0000
  /// -----------------------------------------
  /// * **Calendar type**
  ///   * .E - calender    => ዓ.ም
  /// -----------------------------------------
  /// * **Time**
  ///   * .h - hour        => 1 - 12
  ///   * .mn - minute      => 1 - 60
  ///   * .s - second      => 1 - 60
  String format(
    String pattern, {
    FormatLanguage lang = FormatLanguage.am,
    FormatLength length = FormatLength.short,
  }) =>
      formatDate(pattern, this, lang, length);

  // navigating
  GeezDate add(
      {int years = 0, int months = 0, int weeks = 0, int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    final newDate = Jiffy.parseFromDateTime(toGC())
        .add(years: years, months: months, weeks: weeks, days: days, hours: hours, minutes: minutes, seconds: seconds)
        .dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  GeezDate subtract(
      {int years = 0, int months = 0, int weeks = 0, int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    final newDate = Jiffy.parseFromDateTime(toGC())
        .subtract(
            years: years, months: months, weeks: weeks, days: days, hours: hours, minutes: minutes, seconds: seconds)
        .dateTime;
    return GeezDate.fromDateTime(newDate);
  }

  // checking
  bool get isThisyear => cmp.isSameYear(this, GeezDate.now());
  bool get isThisMonth => cmp.isSameMonth(this, GeezDate.now());
  bool get isToday => cmp.isSameDate(GeezDate.now(), this); // -
  bool get isThisHour => cmp.isSameHour(GeezDate.now(), this); // -
  bool get isThisMinute => cmp.isSameMinute(GeezDate.now(), this); // -
  bool get isThisSecond => cmp.isSameSecond(GeezDate.now(), this); // -
  bool get isFuture => cmp.compare(this, GeezDate.now(), CompareDatesResultUnit.day) > 0;
  bool get isPast => cmp.compare(this, GeezDate.now(), CompareDatesResultUnit.day) < 0;

  // equality
  bool isSameYear(GeezDate date) => cmp.isSameYear(this, date);
  bool isSameMonth(GeezDate date) => cmp.isSameMonth(this, date);
  bool isSameDate(GeezDate date) => cmp.isSameDate(this, date);
  bool isSameDay(GeezDate date) => cmp.isSameDay(this, date);
  bool isSameHour(GeezDate date) => cmp.isSameHour(this, date);
  bool isSameMinute(GeezDate date) => cmp.isSameMinute(this, date);
  bool isSameSecond(GeezDate date) => cmp.isSameSecond(this, date);

  // compare
  num compareTo(GeezDate date, [CompareDatesResultUnit unit = CompareDatesResultUnit.day]) =>
      cmp.compare(this, date, unit);

  @override
  String toString() =>
      "GeezDate ({ year: $year, month: $month, date: $date, hour: $hour, minute: $minute, second: $second })";

  @override
  int get hashCode => int.parse("$year$month$date$hour$minute$second");
}
