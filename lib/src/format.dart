import 'constants.dart';
import '../../../src/geezdate.dart';

enum FormatLanguage {
  english("english"),
  amharic("amharic"),
  tigirigna("tigirigna"),
  oromo("oromo");

  final String text;

  const FormatLanguage(this.text);
}

String format(String pattern, GeezDate geezdate, [FormatLanguage formatLanguage = FormatLanguage.amharic]) {
  final GeezDate(:year, :month, :date) = geezdate;
  final days = getLanguages(formatLanguage.text).days;
  final months = getLanguages(formatLanguage.text).months;

  if (pattern.isEmpty) throw "pattern is empty!";
  if (date < 1 || date > 30) throw "incorrect date! needed 1 - 30, given $date";
  if (month < 1 || month > 13) throw "incorrect month! needed 1 - 13, given $month";

  final gcDate = geezdate.toGc();

  return pattern
      // days
      .replaceAll(RegExp(r"\.d"), "${date < 10 ? "0$date" : date}")
      .replaceAll(RegExp(r"\.D"), days[gcDate.weekday + 1])

      // months
      .replaceAll(RegExp(r"\.m"), "${month < 10 ? "0$month" : month}")
      .replaceAll(RegExp(r"\.M"), months[month - 1])

      // years
      .replaceAll(RegExp(r"\.y+"), "${2016 % 100}")
      .replaceAll(RegExp(r"\.Y"), "$year")

      // EC
      .replaceAll(RegExp(r"\.[Ee]+"), "ዓ.ም");
}
