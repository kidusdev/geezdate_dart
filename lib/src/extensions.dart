import "geezdate.dart";

extension DateTimeGeezDateExtension on DateTime {
  GeezDate toEC() => GeezDate.fromDateTime(this);
}

extension ConvertTimePeriodsToInt on int {
  int get days => this;
  int get months => this * 30;
  int get years => this * 365;
}
