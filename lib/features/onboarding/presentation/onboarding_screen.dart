import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami_app/app/router.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  if (_currentIndex > 0)
                    IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back),
                    )
                  else
                    const SizedBox(width: 48),
                  const Spacer(),
                  isLastPage
                      ? SizedBox(width: 48)
                      : TextButton(
                          onPressed:  _finishOnboarding,
                          child: const Text('Skip'),
                        ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: OnboardingRepo.pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return OnboardingPageView(
                        page: OnboardingRepo.pages[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            DotsIndicator(
              count: OnboardingRepo.pages.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFinishing
                      ? null
                      : (isLastPage ? _finishOnboarding : _nextPage),
                  child: Text(isLastPage ? 'Get Started' : 'Next'),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
