class MoshafModel {
  final int id;
  final String name;
  final String server;
  final int surahTotal;
  final List<int> surahList;

  const MoshafModel({
    required this.id,
    required this.name,
    required this.server,
    required this.surahTotal,
    required this.surahList,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    final rawSurahList = json['surah_list'] as String? ?? '';
    return MoshafModel(
      id: json['id'] as int,
      name: json['name'] as String,
      server: json['server'] as String,
      surahTotal: json['surah_total'] as int,
      surahList: rawSurahList
          .split(',')
          .map((value) => int.tryParse(value.trim()))
          .whereType<int>()
          .toList(growable: false),
    );
  }
}
