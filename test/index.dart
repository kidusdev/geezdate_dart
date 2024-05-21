import "package:intl/intl.dart";
import "package:jiffy/jiffy.dart";

void main() {
  final myDate = DateTime.now();
  final formattedDate = DateFormat('hh:mm a').format(myDate);

  print(Jiffy.now().toLocal().Hms);
  print(formattedDate);
}
