import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami_app/app/router.dart';
import 'package:islami_app/core/services/sharedpreferences_service.dart';

class OnboardingScreen extends StatelessWidget {
  static final String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await SharedpreferencesService.setOnboardingseen();
            if (context.mounted) {
              context.go(AppRoutes.quran);
            }
          },
          child: const Text('Finish Onboarding'),
        ),
      ),
    );
  }
}
