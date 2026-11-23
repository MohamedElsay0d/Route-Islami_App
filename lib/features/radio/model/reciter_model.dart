import 'package:islami_app/features/radio/model/moshaf_model.dart';

class ReciterModel {
  /*
  "id": 1,
            "name": "إبراهيم الأخضر",
            "letter": "إ",
            "date": "2025-09-06T00:39:03.000000Z",
            "moshaf":*/

  final int id;
  final String name;
  final String letter;
  final List<MoshafModel> moshafModel;

  const ReciterModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.moshafModel,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    final rawMoshaf = json['moshaf'] as List<dynamic>? ?? const [];
    return ReciterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      letter: json['letter'] as String? ?? '',
      moshafModel: rawMoshaf
          .map((item) => MoshafModel.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }
}
