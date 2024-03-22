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
const date = GeezDate({ year: 2016, month: 10, date: 11 });

// now
const date = GeezDate.now();

// from DateTime object
const date = GeezDate.fromDate(DateTime.now());

// from string
const date = GeezDate.fromString("11-10-2016");

// from json
const date = GeezDate.fromJson({"year": 2016, "month": 10, "date": 10});
```

### converting to GC

```dart
// converting EC to GC
const date = GeezDate({ year: 2016, month: 10, date: 11 });
const convertedToGC = date.toGC();
```

### operators

```dart
const date = GeezDate({ year: 2016, month: 10, date: 11 });
const anotherDate = GeezDate({ year: 2015, month: 11, date: 10 });

print(date == anotherDate) // false
print(date > anotherDate) // true
print(date < anotherDate) // false
print(date + 1) // GeezDate({ year: 2016, month: 10, date: 12 })
print(date - 1) // GeezDate({ year: 2016, month: 10, date: 10 })
...
```

### formatting

```dart
// NB. if you are in VSCODE hover over the `format` function to get description
const date = GeezDate({ year: 2016, month: 10, date: 11 });

const formatType = FormatLanguage.am;
const formatted = date.toFormatter("ዛሬ ቀኑ .D, .M .d, .Y .E ነው።", formatType);

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

### navigating between dates

```dart
const date = GeezDate({ year: 2016, month: 10, date: 11 });

// adding time
const futureDate = date.add(months: 1, days: 10);

// subtracting time
const pastDate = date.subtract(months: 2, days: 12);
...
```

### checking

```dart
const date = GeezDate({ year: 2016, month: 10, date: 11 });
const anotherDate = GeezDate({ year: 2015, month: 11, date: 10 });

// checking date
const isToday = date.isToday;
const isPast = date.isPast;
const isFuture = date.isFuture;
const isThisMonth = date.isThisMonth;
const isThisYear = date.isThisYear;

// comparing dates
const isSameDate = date.isSameDate(anotherDate);
const isSameDay = date.isSameDay(anotherDate);
const isSameMonth = date.isSameMonth(anotherDate);
const isSameYear = date.isSameYear(anotherDate);
...
```

### outputing date

```dart
const date = GeezDate({ year: 2016, month: 10, date: 11 });

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
