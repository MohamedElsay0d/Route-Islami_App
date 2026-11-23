import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_list_view.dart';
import 'package:islami_app/features/radio/presentation/widget/reciters_list_view.dart';

class RadioTab extends StatelessWidget {
  const RadioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.white,
              labelPadding: EdgeInsets.zero,
              labelStyle: AppTextStyles.titleMedium,
              tabs: [
                Tab(text: "Radio"),
                Tab(text: "Reciter"),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          const Expanded(
            child: TabBarView(children: [RadioListView(), RecitersListView()]),
          ),
        ],
      ),
    );
  }
}
