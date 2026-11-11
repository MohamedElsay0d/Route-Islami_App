import 'package:go_router/go_router.dart';
import 'package:islami_app/core/services/sharedpreferences_service.dart';
import 'package:islami_app/features/hadeth/presentation/hadeth_tab.dart';
import 'package:islami_app/features/home/presentation/home_shell.dart';
import 'package:islami_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:islami_app/features/prayer_times/presentation/prayer_times_tab.dart';
import 'package:islami_app/features/quran/presentation/quran_tab.dart';
import 'package:islami_app/features/radio/presentation/radio_tab.dart';
import 'package:islami_app/features/sebha/presentation/sebha_tab.dart';

abstract final class AppRoutes {
  static final String onBoarding = '/onBoarding';
  static final String quran = '/quran';
  static final String hadeth = '/hadeth';
  static final String radio = '/radio';
  static final String sebha = '/sebha';
  static final String prayerTimes = '/prayerTimes';
}

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: SharedpreferencesService.isOnboardingSeen
        ? AppRoutes.quran
        : AppRoutes.onBoarding,
    routes: [
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.quran,
                builder: (context, state) => const QuranTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.hadeth,
                builder: (context, state) => const HadethTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.sebha,
                builder: (context, state) => const SebhaTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.radio,
                builder: (context, state) => const RadioTab(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.prayerTimes,
                builder: (context, state) => const PrayerTimesTab(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
