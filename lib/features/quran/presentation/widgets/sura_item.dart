import 'package:flutter/material.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';

class SuraItem extends StatelessWidget {
  const SuraItem({
    super.key,
    required this.sura,
    required this.onTap,
  });

  final SuraModel sura;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 52,
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppAssets.suraNumberFrame,
                    width: 52,
                    height: 52,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    '${sura.number}',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.englishName,
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${sura.ayahCount} Verses',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              sura.arabicName,
              style: textTheme.titleLarge,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}