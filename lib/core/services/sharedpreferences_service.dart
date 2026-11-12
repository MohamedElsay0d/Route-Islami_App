import 'package:shared_preferences/shared_preferences.dart';

abstract final class SharedpreferencesService {
  static const String onboardingKey = 'onboarding_seen';

  static late final SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static bool get isOnboardingSeen => _pref.getBool(onboardingKey) ?? false;

  static Future<void> setOnboardingSeen() async =>
      await _pref.setBool(onboardingKey, true);
}
