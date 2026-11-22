import 'package:flutter/material.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/quran/presentation/sura_details_screen.dart';

class BodySuraDetails extends StatelessWidget {
  const BodySuraDetails({super.key, required this._ayatFuture, required this.widget ,required this._retry});

  final Future<List<String>> _ayatFuture;
  final SuraDetailsScreen widget;
  final  _retry ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<String>>(
        future: _ayatFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Could not load the sura',
                      style: TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final ayat = snapshot.data ?? const <String>[];
          if (ayat.isEmpty) {
            return const Center(
              child: Text(
                'No ayat found',
                style: TextStyle(color: AppColors.white),
              ),
            );
          }
          final showNumbers =
               ayat.length == widget.sura.ayahCount;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text.rich(
              TextSpan(children: _buildSpans(ayat, showNumbers)),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTextStyles.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 2.0,
                color: Color(0xFFE8D5A3),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<InlineSpan> _buildSpans(List<String> ayat, bool showNumbers) {
  final spans = <InlineSpan>[];

  for (var i = 0; i < ayat.length; i++) {
    if (showNumbers) {
      spans.add(TextSpan(text: '${ayat[i]} '));
      spans.add(
        TextSpan(
          text: '[${i + 1}] ',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }

  return spans;
}