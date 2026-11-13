import 'package:flutter/widgets.dart';
import 'package:islami_app/core/utils/arabic_normalizer.dart';
import 'package:islami_app/features/quran/data/quran_repo.dart';
import 'package:islami_app/features/quran/data/recent_suras_repo.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';

class QuranController extends ChangeNotifier {
  QuranController(this.quranRepo, this.recentSurasRepo);

  final QuranRepo quranRepo;
  final RecentSurasRepo recentSurasRepo;

  List<SuraModel> _suras = const <SuraModel>[];
  List<SuraModel> _recentSuras = const <SuraModel>[];

  bool _isLoading = false;
  String? _error;
  String _query = '';

  List<SuraModel> get suras => _suras;
  List<SuraModel> get recentSuras => _recentSuras;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get query => _query;

  List<SuraModel> get filteredSuras {
    final normalizedQuery = ArabicNormalizer.normalize(_query);

    if (normalizedQuery.isEmpty) return _suras;

    return _suras
        .where((sura) {
          final arabicName = ArabicNormalizer.normalize(sura.arabicName);
          final englishName = sura.englishName.toLowerCase();

          return arabicName.contains(normalizedQuery) ||
              englishName.contains(normalizedQuery);
        })
        .toList(growable: false);
  }

  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _suras = await quranRepo.getSuras();
      try {
        await _loadRecentSuras();
      } catch (e) {
        debugPrint('QuranController._loadRecentSuras: $e');
      }
    } catch (e) {
      _error = 'QuranController._loadRecentSuras : $e';
      debugPrint('QuranController._loadRecentSuras: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadRecentSuras() async {
    final numbers = await recentSurasRepo.getRecentSurasNumbers();

    final surasByNumber = {
      for (final sura in _suras) sura.number: sura,
    };

    _recentSuras = numbers
        .map((number) => surasByNumber[number])
        .whereType<SuraModel>()
        .toList(growable: false);
  }

   void search(String value) {
    if (_query == value) return;

    _query = value;
    notifyListeners();
  }

  void clearSearch() {
    if (_query.isEmpty) return;

    _query = '';
    notifyListeners();
  }

  Future<void> addToRecent(SuraModel sura) async {
    final updated = <SuraModel>[
      sura,
      ..._recentSuras.where((item) => item.number != sura.number),
    ];

    _recentSuras = updated.take(5).toList(growable: false);
    notifyListeners();

    await recentSurasRepo.saveRecentSurasNumbers(
      _recentSuras.map((item) => item.number).toList(growable: false),
    );
  }

  Future<void> removeRecent(SuraModel sura) async {
    _recentSuras = _recentSuras
        .where((item) => item.number != sura.number)
        .toList(growable: false);

    notifyListeners();

    await recentSurasRepo.saveRecentSurasNumbers(
      _recentSuras.map((item) => item.number).toList(growable: false),
    );
  }
}
