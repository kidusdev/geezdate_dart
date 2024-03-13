# GEEZDATE

A simple and minimalisting date utility that helps you work with ethiopian date in dart/flutter.
እኛ ራሳችን ለራሳችን ካልሰራን ማን ይሰራልናል። ኣንድ ፈረንጅ መቶ ኣይሰራልን።

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
const convertedToGC = date.toGc();
```

### formatting

```dart
// formatting
// NB. if you are in VSCODE hover over the `format` function to get description
const date = GeezDate({ year: 2016, month: 10, date: 11 });

// Languages
// FormatLanguage.english;
// FormatLanguage.amharic;
// FormatLanguage.tigirigna;
// FormatLanguage.oromo;
const formatType = FormatLanguage.amharic;
const formatted = date.toFormatter("ዛሬ ቀኑ .D, .M .d, .Y .E ነው።", formatType);

console.log(formatted); // ዛሬ ቀኑ ዓርብ, መጋቢት 06, 2016 ዓ.ም ነው።

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
const futureDate = date.add(days:1, months:2);

// subtracting time
const pastDate = date.subtract(days:1, months:2);
...
```

### checking

```dart
const date = GeezDate({ year: 2016, month: 10, date: 11 });
const anotherDate = GeezDate({ year: 2015, month: 11, date: 10 });

const isToday = date.isToday;
const isPast = date.isPast;
const isFuture = date.isFuture;
...
```

#### Upcoming Features

- Formatting date in all ethiopian languages
- difference between two dates
- working with time (hours, minutes and seconds)
- parsing different types of date to GeezDate
- and more

> to contribute send pull request github
