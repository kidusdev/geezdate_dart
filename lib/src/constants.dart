import 'package:geezdate/geezdate.dart';

({
  List<String> days,
  List<String> daysInShorts,
  List<String> months,
  List<String> monthsInShorts,
}) getLanguages(FormatLanguage lang) {
  return switch (lang) {
    FormatLanguage.en => _english,
    FormatLanguage.am => _amharic,
    FormatLanguage.ti => _tigirigna,
    FormatLanguage.or => _oromo,
  };
}

const _english = (
  days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
  daysInShorts: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  months: [
    "September",
    "October",
    "November",
    "December",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "Pagumen"
  ],
  monthsInShorts: ["Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Pag"],
);

const _amharic = (
  days: ["ሰኞ", "ማክሰኞ", "ረቡዕ", "ሐሙስ", "ዓርብ", "ቅዳሜ", "እሁድ"],
  daysInShorts: ["ሰኞ", "ማክ", "ረቡ", "ሐሙ", "ዓር", "ቅዳ", "እሁ"],
  months: ["መስከረም", "ጥቅምት", "ህዳር", "ታህሳስ", "ጥር", "የካቲት", "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜ"],
  monthsInShorts: ["መስ", "ጥቅ", "ህዳ", "ታህ", "ጥር", "የካ", "መጋ", "ሚያ", "ግን", "ሰኔ", "ሐም", "ነሐ", "ጳጉ"],
);

const _tigirigna = (
  days: ["ሰኒ", "ሰሉስ", "ረቡዕ", "ሓሙስ", "ዓርቢ", "ቐዳም", "ሰንበት"],
  daysInShorts: ["ሰኒ", "ሰሉ", "ረቡ", "ሓሙ", "ዓር", "ቐዳ", "ሰን"],
  months: ["መስከረም", "ጥቅምቲ", "ሕዳር", "ታሕሳስ", "ጥሪ", "ለካቲት", "መጋቢት", "ሚያዝያ", "ጉንበት", "ሰነ", "ሓምለ", "ነሓሰ", "ጳጉሜ"],
  monthsInShorts: ["መስ", "ጥቅ", "ሕዳ", "ታሕ", "ጥሪ", "ለካ", "መጋ", "ሚያ", "ጉን", "ሰነ", "ሓም", "ነሓ", "ጳጉ"],
);

const _oromo = (
  days: ["Wixata", "Kibxata", "Roobii", "Kamiisa", "Jimaata", "Sanbata", "Dilbata"],
  daysInShorts: ["Wix", "Kib", "Roo", "Kam", "Jim", "San", "Dil"],
  months: [
    "Fuulbana",
    "Onkololeessa",
    "Sadaasa",
    "Muddee",
    "Amajjii",
    "Guraandhala",
    "Bitooteessa",
    "Elba",
    "Caamsa",
    "Waxabajjii",
    "Adooleessa",
    "Hagayya",
    "Pagume"
  ],
  monthsInShorts: ["Fuu", "Onk", "Sad", "Mud", "Ama", "Gur", "Bit", "Elb", "Caa", "Wax", "Ado", "Hag", "Pag"],
);
