import 'package:flutter/material.dart';
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
          Expanded(
            flex: 6,
            child: Image.asset(page.image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          Text(
            page.title,
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          if (page.subtitle.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              page.subtitle,
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
