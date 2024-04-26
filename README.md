# GEEZDATE

A simple and minimalisting date utility that helps you to work with ethiopian date in dart/flutter.

## Installation

- using dart

```console
$ dart pub add geezdate
```

- using flutter

```console
$ flutter pub add geezdate
```

## Usage

### creating instance of GeezDate

```dart
// literal GeezDate
final date = GeezDate({ year: 2016, month: 10, date: 11 });

// now
final date = GeezDate.now();

// from DateTime object
final date = GeezDate.fromDate(DateTime.now());

// from string must be date-month-year
final date = GeezDate.fromString("11-10-2016");

// from json
final date = GeezDate.fromJson({"year": 2016, "month": 10, "date": 10});
```

### converting

```dart
// converting EC to GC
final gc = GeezDate({ year: 2016, month: 10, date: 11 }).toGC();

// converting GC to EC
final ec = GeezDate.fromDateTime(DateTime.now());

// converting through extensions
final ec2 = DateTime.now().toEC();

```

### operators

```dart
final date = GeezDate({ year: 2016, month: 10, date: 11 });
final anotherDate = GeezDate({ year: 2015, month: 11, date: 10 });

print(date == anotherDate) // false
print(date > anotherDate) // true
print(date < anotherDate) // false
print(date + 1) // GeezDate({ year: 2016, month: 10, date: 12 })
print(date - 1) // GeezDate({ year: 2016, month: 10, date: 10 })
...
```

### formatting

```dart
// NB. if you are in VSCODE hover over the `format` function to get the below description
final date = GeezDate({ year: 2016, month: 10, date: 11 });

final formatType = FormatLanguage.am;
final formatted = date.toFormatter("ዛሬ ቀኑ .D, .M .d, .Y .E ነው።", formatType);

console.log(formatted); // ዛሬ ቀኑ ዓርብ, መጋቢት 06, 2016 ዓ.ም ነው።

// Languages
// FormatLanguage.en for english;
// FormatLanguage.am for amharic;
// FormatLanguage.ti for tigrigna;
// FormatLanguage.or for oromifa;

// Formatting Strings
// .d     - date          => 1 - 30
// .D     - day           => እሁድ - ቅዳሜ
// .m     - month index   => 1 - 13
// .M     - month name    => መስከረም - ጳጉሜ
// .y     - year          => 00
// .Y     - year          => 0000
// .E     - calender      => ዓ.ም

```

### adding and subtracting from dates

```dart
final date = GeezDate({ year: 2016, month: 3, date: 11 });

// adding time
final futureDate = date.add(months: 1, days: 10);

// subtracting time
final pastDate = date.subtract(months: 2, days: 12);

// adding through extensions
print(date + 3.days) // GeezDate({ year: 2016, month: 3, date: 14 })
print(date + 3.days + 2.months) // GeezDate({ year: 2016, month: 5, date: 14 })
print(date + 2.years) // GeezDate({ year: 2018, month: 3, date: 11 })
print(date + 2.years + 2.months) // GeezDate({ year: 2018, month: 5, date: 11 })
...
```

### checking

```dart
final date = GeezDate({ year: 2016, month: 10, date: 11 });
final anotherDate = GeezDate({ year: 2015, month: 11, date: 10 });

// checking date
final isToday = date.isToday;
final isPast = date.isPast;
final isFuture = date.isFuture;
final isThisMonth = date.isThisMonth;
final isThisYear = date.isThisYear;

// comparing dates
final isSameDate = date.isSameDate(anotherDate);
final isSameDay = date.isSameDay(anotherDate);
final isSameMonth = date.isSameMonth(anotherDate);
final isSameYear = date.isSameYear(anotherDate);
...
```

### outputing date

```dart
final date = GeezDate({ year: 2016, month: 10, date: 11 });

print(date.toString())
// GeezDate ({ year: 2016, month: 10, date: 11 })

print(date.hashCode)
// 20161011
```

#### Upcoming Features

- Formatting date in all ethiopian languages
- difference between two dates
- working with time (hours, minutes and seconds)
- parsing different types of date to GeezDate
- and more

> to contribute send pull request github
