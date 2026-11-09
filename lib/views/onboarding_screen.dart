import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  static final String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Onboarding'),
        ],
      ),
    );
  }
}