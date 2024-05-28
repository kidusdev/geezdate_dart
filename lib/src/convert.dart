import 'package:geezdate/geezdate.dart';

const _jdEpochOffsetAmeteAlem = -285019; //      ዓ/ዓ
const _jdEpochOffsetAmeteMihret = 1723856; //    ዓ/ም
const _jdEpochOffsetGregorian = 1721426;
const _jdEpochOffsetUnset = -1;

int _jdnOffset = _jdEpochOffsetUnset;

const _gregorianNumberOfMonths = 12;
List<int> _monthDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

// Helpers
int _quotient(num i, num j) => (i / j).floor();
num _mod(num i, num j) => i % j;
bool _isGregorianLeap(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

// Era Helpers
void _setEra(int era) => _jdnOffset =
    (era == _jdEpochOffsetAmeteAlem) || (era == _jdEpochOffsetAmeteMihret) ? era : throw "Unknown Era: $era";
bool _isEraSet() => _jdEpochOffsetUnset != _jdnOffset;
void _unsetEra() => _jdnOffset = _jdEpochOffsetUnset;
int _guessEraFromJDN(int jdn) =>
    (jdn >= (_jdEpochOffsetAmeteMihret + 365)) ? _jdEpochOffsetAmeteMihret : _jdEpochOffsetAmeteAlem;

// Conversion
num _ethiopicToJDN(int day, int month, int year) {
  final era = _isEraSet() ? _jdnOffset : _jdEpochOffsetAmeteMihret;
  final jdn = (era + 365) + 365 * (year - 1) + _quotient(year, 4) + 30 * month + day - 31;
  return jdn;
}

({int year, int month, int date}) _jdnToEthiopic(int jdn) {
  final era = _isEraSet() ? _jdnOffset : _guessEraFromJDN(jdn);
  final r = _mod((jdn - era), 1461);
  final n = _mod(r, 365) + 365 * _quotient(r.toInt(), 1460);
  final year = 4 * _quotient((jdn - era), 1461) + _quotient(r.toInt(), 365) - _quotient(r.toInt(), 1460);
  final month = _quotient(n.toInt(), 30) + 1;
  final day = _mod(n, 30) + 1;

  return (year: year, month: month, date: day.toInt());
}

int _gregorianToJDN(int day, int month, int year) {
  final s = _quotient(year, 4) -
      _quotient(year - 1, 4) -
      _quotient(year, 100) +
      _quotient(year - 1, 100) +
      _quotient(year, 400) -
      _quotient(year - 1, 400);

  final t = _quotient(14 - month, 12);

  final n = 31 * t * (month - 1) + (1 - t) * (59 + s + 30 * (month - 3) + _quotient((3 * month - 7), 5)) + day - 1;

  final j = _jdEpochOffsetGregorian +
      365 * (year - 1) +
      _quotient(year - 1, 4) -
      _quotient(year - 1, 100) +
      _quotient(year - 1, 400) +
      n;

  return j.toInt();
}

({int year, int month, int date}) _jdnToGregorian(int jdn) {
  final r2000 = _mod((jdn - _jdEpochOffsetGregorian), 730485);
  final r400 = _mod((jdn - _jdEpochOffsetGregorian), 146097);
  final r100 = _mod(r400, 36524);
  final r4 = _mod(r100, 1461);
  var n = _mod(r4, 365) + 365 * _quotient(r4, 1460);
  final s = _quotient(r4, 1095);
  final aprime = 400 * _quotient((jdn - _jdEpochOffsetGregorian), 146097) +
      100 * _quotient(r400, 36524) +
      4 * _quotient(r100, 1461) +
      _quotient(r4, 365) -
      _quotient(r4, 1460) -
      _quotient(r2000, 730484);
  final year = aprime + 1;
  final t = _quotient((364 + s - n), 306);
  var month = t * (_quotient(n, 31) + 1) + (1 - t) * (_quotient((5 * (n - s) + 13), 153) + 1);
  n += 1 - _quotient(r2000, 730484);
  var day = n;

  if ((r100 == 0) && (n == 0) && (r400 != 0)) {
    month = 12;
    day = 31;
  } else {
    _monthDays[2] = (_isGregorianLeap(year)) ? 29 : 28;
    for (var i = 1; i <= _gregorianNumberOfMonths; i += 1) {
      if (n <= _monthDays[i]) {
        day = n;
        break;
      }
      n -= _monthDays[i];
    }
  }
  return (year: year, month: month, date: day.toInt());
}

// info: Converters
to12HoursFormat(int hour) => switch (hour) { > 12 => hour - 12, 0 => 12, _ => hour };

({int hour, Shift shift}) localForeignTime(int hour) {
  final isDayShift = hour >= 6 && hour <= 17;
  final shift = isDayShift ? Shift.day : Shift.night;

  final timeIn12HoursFormat = to12HoursFormat(hour);
  int hr = switch (timeIn12HoursFormat) {
    1 => 7,
    2 => 8,
    3 => 9,
    4 => 10,
    5 => 11,
    6 => 12,
    7 => 1,
    8 => 2,
    9 => 3,
    10 => 4,
    11 => 5,
    12 => 6,
    _ => hour,
  };

  return (hour: hr, shift: shift);
}

({int date, int month, int year}) _gregorianToEthiopic(int day, int month, int year) {
  final jdn = _gregorianToJDN(day, month, year);
  return _jdnToEthiopic(jdn);
}

({int date, int month, int year}) _ethioipicToGregorian(int day, int month, int year, int era) {
  _setEra(era);
  final jdn = _ethiopicToJDN(day, month, year);
  final result = _jdnToGregorian(jdn.toInt());
  _unsetEra();
  return result;
}

// info: APIS
// ec to gc
DateTime toGC(GeezDate date) {
  final GeezDate(year: y, month: m, date: d, :hour, :minute, :second) = date;
  if (d < 0 || d > 30 || m < 0 || m > 13) throw 'Invalid Ethiopian Date';

  final converted = _ethioipicToGregorian(d, m, y, _jdEpochOffsetAmeteMihret);
  final now = DateTime.now();
  return DateTime(
    converted.year,
    converted.month,
    converted.date,
    localForeignTime(hour).hour,
    minute,
    second,
    now.millisecond,
    now.microsecond,
  );
}

// gc to ec
GeezDate toEC(DateTime date) {
  final DateTime(year: y, month: m, day: d, hour: hr, minute: min, second: sec) = date;
  if (d < 0 || d > 31 || m < 0 || m > 12) throw 'Invalid Gregorian Date';

  final localTime = localForeignTime(hr);

  final converted = _gregorianToEthiopic(d, m, y);
  return GeezDate(
    converted.year,
    converted.month,
    converted.date,
    localTime.hour,
    min,
    sec,
    localTime.shift,
  );
}
