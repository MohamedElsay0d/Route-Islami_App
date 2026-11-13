class SuraModel {
  final int number;
  final String arabicName;
  final String englishName;
  final int ayahCount;

  const SuraModel({
    required this.number,
    required this.arabicName,
    required this.englishName,
    required this.ayahCount,
  });

  factory SuraModel.fromJson(Map<String, dynamic> json) {
    return SuraModel(
      number: json['number'] as int,
      arabicName: json['arabicName'] as String,
      englishName: json['englishName'] as String,
      ayahCount: json['ayahCount'] as int,
    );
  }
}
