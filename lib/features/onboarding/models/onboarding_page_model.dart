class OnboardingPageModel {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingPageModel({
    required this.title,
    this.subtitle = '',
    required this.image,
  });
}
