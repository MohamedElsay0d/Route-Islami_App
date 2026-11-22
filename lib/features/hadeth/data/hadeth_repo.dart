import 'package:flutter/services.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/features/hadeth/model/hadeth_model.dart';

class HadethRepo {
  Future<List<HadethModel>> getAllHadeth() async {
    String jsonString;
    int id = 0;
    List<String> lines;
    String title;
    String content;
    final hadethList = List.generate(50, (index) async {
      id = index + 1;
      jsonString = await rootBundle.loadString(
        '${AppAssets.hadethsPath}h$id.txt',
      );
      jsonString = jsonString.replaceFirst('\uFEFF', '');
      jsonString = jsonString.trim();

       lines = jsonString.split('\n');
       title = lines.first.trim();
       content = lines.skip(1).join('\n').trim();
      return HadethModel(id, title, content);
    });
    return Future.wait(hadethList);
  }
}
