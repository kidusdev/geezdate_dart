({List<String> days, List<String> months}) getLanguages(String lang) {
  return switch (lang) {
    "english" => _english,
    "amharic" => _amharic,
    "tigirigna" => _tigirigna,
    "oromo" => _oromo,
    _ => _amharic,
  };
}

const _english = (
  days: ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"],
  months: [
    "september",
    "october",
    "november",
    "december",
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "pagumen"
  ],
);

const _amharic = (
  days: ["እሁድ", "ሰኞ", "ማክሰኞ", "ረቡዕ", "ሐሙስ", "ዓርብ", "ቅዳሜ"],
  months: ["መስከረም", "ጥቅምት", "ህዳር", "ታህሳስ", "ጥር", "የካቲት", "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜ"],
);

const _tigirigna = (
  days: ["ሰንበት", "ሰኒ", "ሰሉስ", "ረቡዕ", "ሓሙስ", "ዓርቢ", "ቐዳም"],
  months: ["መስከረም", "ጥቅምቲ", "ሕዳር", "ታሕሳስ", "ጥሪ", "ለካቲት", "መጋቢት", "ሚያዝያ", "ጉንበት", "ሰነ", "ሓምለ", "ነሓሰ", "ጳጉሜ"],
);

const _oromo = (
  days: ["dilbata", "wixata", "kibxata", "roobii", "kamiisa", "jimaata", "sanbata"],
  months: [
    "fuulbana",
    "onkololeessa",
    "sadaasa",
    "muddee",
    "amajjii",
    "guraandhala",
    "bitooteessa",
    "elba",
    "caamsa",
    "waxabajjii",
    "adooleessa",
    "hagayya",
    "pagume"
  ],
);
