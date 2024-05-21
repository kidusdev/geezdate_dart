import 'package:jiffy/jiffy.dart';

// =====================================================

enum CompareDatesResultUnit {
  day(Unit.day),
  month(Unit.month),
  year(Unit.year);

  final Unit unit;

  const CompareDatesResultUnit(this.unit);
}

// =====================================================

enum FormatLanguage {
  en("english"),
  am("amharic"),
  ti("tigirigna"),
  or("oromifa");

  final String text;

  const FormatLanguage(this.text);
}

// =====================================================

enum FormatLength {
  short("short"),
  long("long");

  final String text;

  const FormatLength(this.text);
}
