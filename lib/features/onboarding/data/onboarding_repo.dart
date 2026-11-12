import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/features/onboarding/models/onboarding_page_model.dart';

abstract final class OnboardingRepo {
  static const  List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      image: AppAssets.onBoarding1,
      title: 'Welcome to Islami',
      subtitle: 'Your daily companion for Quran, Hadeth, and prayer times.',
    ),
    OnboardingPageModel(
      image: AppAssets.onBoarding2,
      title: 'Welcome to Our Community',
      subtitle: 'We are very excited to have you with us.',
    ),
    OnboardingPageModel(
      image: AppAssets.onBoarding3,
      title: 'Read the Quran',
      subtitle: 'Read, and your Lord is the Most Generous.',
    ),
    OnboardingPageModel(
      image: AppAssets.onBoarding4,
      title: 'Sebha',
      subtitle: 'Praise the name of your Lord, the Most High.',
    ),
    OnboardingPageModel(
      image: AppAssets.onBoarding5,
      title: 'Holy Quran Radio',
      subtitle: 'Listen to the Holy Quran Radio for free, anytime.',
    ),
  ];
}
