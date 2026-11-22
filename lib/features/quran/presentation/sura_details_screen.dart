import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/quran/data/quran_repo.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';
import 'package:islami_app/features/quran/presentation/widgets/body_sura_details.dart';
import 'package:provider/provider.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key, required this.sura});
  final SuraModel sura;

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late Future<List<String>> _ayatFuture;

  @override
  void initState() {
    super.initState();
    _ayatFuture = _loadAyat();
  }

  Future<List<String>> _loadAyat() {
    return context.read<QuranRepo>().getSuraAyat(widget.sura.number);
  }

  void _retry() {
    setState(() {
      _ayatFuture = _loadAyat();
    });
  }

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
          widget.sura.englishName,
          style: const TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.detailsHeaderLeft,
                    width: 75.w,
                    height: 75.h,
                  ),
                  Text(
                    widget.sura.arabicName,
                    style: const TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  Image.asset(
                    AppAssets.detailsHeaderRight,
                    width: 75.w,
                    height: 75.h,
                  ),
                ],
              ),
            ),

            // Body
            BodySuraDetails(ayatFuture: _ayatFuture, widget: widget ,retry: _retry,),
            Image.asset(
              AppAssets.mosque,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}