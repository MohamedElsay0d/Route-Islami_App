import 'package:shared_preferences/shared_preferences.dart';

class RecentSurasRepo {
  static const String _key = 'recent_suras';

  Future<List<int>> getRecentSurasNumbers() async {
    final pref = await SharedPreferences.getInstance();

    final values = pref.getStringList(_key) ?? const <String>[];

    return values.map(int.parse).whereType<int>().toList(growable: false);
  }

  Future<void> saveRecentSurasNumbers(List<int> numbers) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList(
      _key,
      numbers.map((number) => number.toString()).toList(growable: false),
    );
  }
}
