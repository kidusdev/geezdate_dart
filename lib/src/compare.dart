import 'package:geezdate/geezdate.dart';
import 'package:jiffy/jiffy.dart';

// .where((e) =>
//     e.startDate!.toEC() < (date ?? value.date) + 1.days &&
//     (e.endDate == null || e.endDate!.toEC() > (date ?? value.date) + 1.days))
// // convert

//

// difference in numbers between 2 and more dates
bool isBetween(GeezDate one, GeezDate two, GeezDate three) => one >= two && one < three;
num compare(GeezDate one, GeezDate two, [CompareDatesResultUnit unit = CompareDatesResultUnit.day]) =>
    Jiffy.parseFromDateTime(one.toGC()).diff(Jiffy.parseFromDateTime(two.toGC()), unit: unit.unit);

// equality of two dates
bool isSameDate(GeezDate one, GeezDate two) => one.year == two.year && one.month == two.month && one.date == two.date;
bool isSameDay(GeezDate one, GeezDate two) => one.toGC().weekday == one.toGC().weekday;
bool isSameMonth(GeezDate one, GeezDate two) => one.year == two.year && one.month == two.month;
bool isSameYear(GeezDate one, GeezDate two) => one.year == two.year;

// equality of two dates
bool isSameHour(GeezDate one, GeezDate two) =>
    one.year == two.year && one.month == two.month && one.date == two.date && one.hour == two.hour;
bool isSameMinute(GeezDate one, GeezDate two) =>
    one.year == two.year &&
    one.month == two.month &&
    one.date == two.date &&
    one.hour == two.hour &&
    one.minute == two.minute;
bool isSameSecond(GeezDate one, GeezDate two) =>
    one.year == two.year &&
    one.month == two.month &&
    one.date == two.date &&
    one.hour == two.hour &&
    one.minute == two.minute &&
    one.second == two.second;
