import 'package:flutter/foundation.dart';
import 'package:islami_app/features/radio/data/radio_repo.dart';
import 'package:islami_app/features/radio/model/radio_model.dart';
import 'package:islami_app/features/radio/model/reciter_model.dart';

class RadioController extends ChangeNotifier {
  RadioController(this._repo);

  final RadioRepo _repo;

  List<RadioModel> _radios = const <RadioModel>[];
  List<ReciterModel> _reciters = const <ReciterModel>[];

  String? _radiosError;
  String? _recitersError;

  bool _isLoadingRadios = false;
  bool _isLoadingReciters = false;

  List<RadioModel> get radios => _radios;
  List<ReciterModel> get reciters => _reciters;

  bool get isLoadingRadios => _isLoadingRadios;
  bool get isLoadingReciters => _isLoadingReciters;

  String? get radiosError => _radiosError;
  String? get recitersError => _recitersError;

  Future<void> loadRadios() async {
    if (_isLoadingRadios) return;

    _isLoadingRadios = true;
    _radiosError = null;
    notifyListeners();

    try {
      _radios = await _repo.getRadios();
    } catch (e) {
      _radiosError = e.toString();
    } finally {
      _isLoadingRadios = false;
      notifyListeners();
    }
  }

  Future<void> loadReciters() async {
    if (_isLoadingReciters) return;

    _isLoadingReciters = true;
    _recitersError = null;
    notifyListeners();

    try {
      _reciters = await _repo.getReciters();
    } catch (e) {
      _recitersError = e.toString();
    } finally {
      _isLoadingReciters = false;
      notifyListeners();
    }
  }

  Future<void> loadAll() async {
    await Future.wait([loadRadios(), loadReciters()]);

    debugPrint('Radios: ${_radios.length} | error: $_radiosError');
    debugPrint('Reciters: ${_reciters.length} | error: $_recitersError');
  }
}