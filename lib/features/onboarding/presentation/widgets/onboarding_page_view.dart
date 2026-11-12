import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/features/onboarding/models/onboarding_page_model.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({super.key, required this.page});
  final OnboardingPageModel page;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image),
           SizedBox(height: 20.h),
          Text(
            page.title,
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
           SizedBox(height: 40.h),
          if (page.subtitle.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              page.subtitle,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
