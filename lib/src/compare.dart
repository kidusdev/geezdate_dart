import 'package:geezdate/geezdate.dart';
import 'package:jiffy/jiffy.dart';

// difference in numbers between 2 dates
num compare(GeezDate one, GeezDate two, [CompareDatesResultUnit unit = CompareDatesResultUnit.day]) =>
    Jiffy.parseFromDateTime(one.toGC()).diff(Jiffy.parseFromDateTime(two.toGC()), unit: unit.unit);

// equality of two dates
bool isSameDate(GeezDate one, GeezDate two) => one.year == two.year && one.month == two.month && one.date == two.date;
bool isSameDay(GeezDate one, GeezDate two) => one.toGC().weekday == one.toGC().weekday;
bool isSameMonth(GeezDate one, GeezDate two) => one.year == two.year && one.month == two.month;
bool isSameYear(GeezDate one, GeezDate two) => one.year == two.year;
