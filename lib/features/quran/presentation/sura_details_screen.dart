import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';

class SuraDetailsScreen extends StatelessWidget {
  const SuraDetailsScreen({super.key, required this.sura});
  final SuraModel sura;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          sura.englishName,
          style: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(child: Column()),
    );
  }
}
