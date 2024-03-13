import '../../../src/geezdate.dart';

double startDayOfEthiopian(int year) {
  final newYearDay = (year / 100).floor() - (year / 400) - 4;
  return (year - 1) % 4 == 3 ? newYearDay + 1 : newYearDay;
}

// TOEC ==============================================================================================
GeezDate toEC(DateTime inputDate) {
  List<num> gregorianMonths = [0.0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<num> ethiopianMonths = [0.0, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5, 30, 30, 30, 30];
  final DateTime(:year, :month, day: date) = inputDate;

  if (month == 10 && date >= 5 && date <= 14 && year == 1582) {
    throw "Invalid Date between 5-14 May 1582.";
  }

  // if gregorian leap year, February has 29 days.
  if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) gregorianMonths[2] = 29;

  // September sees 8y difference
  num ethiopianYear = year - 8;

  // if ethiopian leap year pagumain has 6 days
  if (ethiopianYear % 4 == 3) ethiopianMonths[10] = 6;

  // Ethiopian new year in Gregorian calendar
  final newYearDay = startDayOfEthiopian(year - 8);

  // calculate number of days up to that date
  num until = 0;
  // ignore: curly_braces_in_flow_control_structures
  for (int i = 1; i < month; i++) until += gregorianMonths[i];
  until += date;

  // update tahissas (december) to match january 1st
  num tahissas = ethiopianYear % 4 == 0 ? 26 : 25;

  // take into account the 1582 change
  if (year < 1582) {
    ethiopianMonths[1] = 0;
    ethiopianMonths[2] = tahissas;
  } else if (until <= 277 && year == 1582) {
    ethiopianMonths[1] = 0;
    ethiopianMonths[2] = tahissas;
  } else {
    tahissas = newYearDay - 3;
    ethiopianMonths[1] = tahissas;
  }

  // calculate month and date incremently
  int m;
  num ethiopianDate = 1;
  for (m = 1; m < ethiopianMonths.length; m++) {
    if (until <= ethiopianMonths[m]) {
      ethiopianDate = m == 1 || ethiopianMonths[m] == 0 ? until + (30 - tahissas) : until;
      break;
    } else {
      until -= ethiopianMonths[m];
    }
  }

  // if m > 10, we're already on next Ethiopian year
  if (m > 10) ethiopianYear += 1;

  // Ethiopian months ordered according to Gregorian
  final order = [0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4];
  final ethiopianMonth = order[m.toInt()];
  return GeezDate(ethiopianYear.toInt(), ethiopianMonth.toInt(), ethiopianDate.toInt());
}

// TOGC ==============================================================================================
DateTime toGC(GeezDate inputDate) {
  final GeezDate(:year, :month, :date) = inputDate;

  // Ethiopian new year in Gregorian calendar
  final newYearDay = startDayOfEthiopian(year);

  // September (Ethiopian) sees 7y difference
  int gregorianYear = year + 7;

  // Number of days in gregorian months
  // starting with September (index 1)
  // Index 0 is reserved for leap years switches.
  // Index 4 is December, the final month of the year.
  List<num> gregorianMonths = [0.0, 30, 31, 30, 31, 31, 28, 31, 30, 31, 30, 31, 31, 30];

  // if next gregorian year is leap year, February has 29 days.
  final nextYear = gregorianYear + 1;
  if ((nextYear % 4 == 0 && nextYear % 100 != 0) || nextYear % 400 == 0) {
    gregorianMonths[6] = 29;
  }

  // calculate number of days up to that date
  num until = (month - 1) * 30.0 + date;
  if (until <= 37 && year <= 1575) {
    // mysterious rule
    until += 28;
    gregorianMonths[0] = 31;
  } else {
    until += newYearDay - 1;
  }

  // if ethiopian year is leap year, paguemain has six days
  if (year - (1 % 4) == 3) {
    until += 1;
  }

  // calculate month and date incremently
  int m = 0;
  num gregorianDate = DateTime.now().day;
  for (int i = 0; i < gregorianMonths.length; i++) {
    if (until <= gregorianMonths[i]) {
      m = i;
      gregorianDate = until;
      break;
    } else {
      m = i;
      until -= gregorianMonths[i];
    }
  }

  // if m > 4, we're already on next Gregorian year
  if (m > 4) {
    gregorianYear += 1;
  }

  // Gregorian months ordered according to Ethiopian
  const order = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  final gYear = gregorianYear;
  final gMonth = order[m];
  return DateTime(gYear, gMonth, gregorianDate.ceil());
}
