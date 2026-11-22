import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/hadeth/model/hadeth_model.dart';

class HadethCard extends StatelessWidget {
  const HadethCard({super.key, required this.hadeth});
  final HadethModel hadeth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.detailsHeaderLeft,
                  width: 75.w,
                  height: 75.h,
                  color: AppColors.darkBackground,
                ),

                Expanded(
                  child: Text(
                    hadeth.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),

                Image.asset(
                  AppAssets.detailsHeaderRight,
                  width: 75.w,
                  height: 75.h,
                  color: AppColors.darkBackground,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Text(
                hadeth.content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 2.0,
                  color: AppColors.darkBackground,
                ),
              ),
            ),
          ),
          Image.asset(
            AppAssets.mosque,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            color: AppColors.darkBackground,
          ),
        ],
      ),
    );
  }
}
