import "geezdate.dart";

extension DateTimeGeezDateExtension on DateTime {
  GeezDate toEC() => GeezDate.fromDateTime(this);
}

extension ConvertTimePeriodsToInt on int {
  int get years => this * 31536000;
  int get months => this * 2628288;
  int get days => this * 86400;
  int get hours => this * 3600;
  int get minutes => this * 60;
  int get seconds => this;
}

extension DateFormat on DateTime {
  String format(String pattern) => GeezDate.formatGC(this, pattern);
}
