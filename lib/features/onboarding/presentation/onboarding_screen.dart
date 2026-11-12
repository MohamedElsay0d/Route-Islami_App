import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami_app/app/router.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/core/services/sharedpreferences_service.dart';
import 'package:islami_app/features/onboarding/data/onboarding_repo.dart';
import 'package:islami_app/features/onboarding/presentation/widgets/dots_indicator.dart';
import 'package:islami_app/features/onboarding/presentation/widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  static final String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isFinishing = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) return;
    setState(() {
      _isFinishing = true;
    });
    await SharedpreferencesService.setOnboardingSeen();

    if (!mounted) return;

    context.go(AppRoutes.quran);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == OnboardingRepo.pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(AppAssets.header, height: 120.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: isLastPage
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(
                        onPressed: _finishOnboarding,
                        child: const Text('Skip'),
                      ),
                    ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingRepo.pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingPageView(page: OnboardingRepo.pages[index]);
                },
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (_currentIndex > 0)
                    ? TextButton(onPressed: _previousPage, child: Text('Back'))
                    : SizedBox(width: 70.w),
                DotsIndicator(
                  count: OnboardingRepo.pages.length,
                  currentIndex: _currentIndex,
                ),
                TextButton(
                  onPressed: _isFinishing
                      ? null
                      : (isLastPage ? _finishOnboarding : _nextPage),
                  child: Text(isLastPage ? 'Finish' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
