import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';

class QuranRepo {
  Future<List<SuraModel>> getSuras() async {
    final jsonString = await rootBundle.loadString(AppAssets.surasJson);
    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList
        .map((item) => SuraModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<List<String>> getSuraAyat(int suraNumber) async {
    final content = await rootBundle.loadString(
      '${AppAssets.surasTextPath}/$suraNumber.txt',
    );
    return content
        .replaceFirst('\uFEFF', '')
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
  } 
}
