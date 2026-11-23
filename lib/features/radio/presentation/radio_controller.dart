import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:islami_app/features/radio/data/radio_repo.dart';
import 'package:islami_app/features/radio/model/radio_model.dart';
import 'package:islami_app/features/radio/model/reciter_model.dart';
import 'package:just_audio/just_audio.dart';

class RadioController extends ChangeNotifier {
  RadioController(this._repo) {
    _playerStateSubscription = _player.playerStateStream.listen(
      _onPlayerState,
    );

    _playerErrorSubscription = _player.playbackEventStream.listen(
      (_) {},
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Radio playback error: $error');
        _resetPlayback();
      },
    );
  }

  final RadioRepo _repo;
  final AudioPlayer _player = AudioPlayer();

  late final StreamSubscription<PlayerState> _playerStateSubscription;
  late final StreamSubscription<PlaybackEvent> _playerErrorSubscription;

  List<RadioModel> _radios = const <RadioModel>[];
  List<ReciterModel> _reciters = const <ReciterModel>[];

  String? _radiosError;
  String? _recitersError;

  bool _isLoadingRadios = false;
  bool _isLoadingReciters = false;

  int? _activeRadioId;
  bool _isPlaying = false;
  bool _isMuted = false;
  int _playRequestId = 0;

  List<RadioModel> get radios => _radios;
  List<ReciterModel> get reciters => _reciters;

  bool get isLoadingRadios => _isLoadingRadios;
  bool get isLoadingReciters => _isLoadingReciters;

  String? get radiosError => _radiosError;
  String? get recitersError => _recitersError;

  int? get activeRadioId => _activeRadioId;
  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;

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

  Future<String?> toggleRadio(RadioModel radio) async {
    if (_activeRadioId == radio.id) {
      if (_player.playing) {
        await _player.pause();
      } else {
        unawaited(_player.play());
      }
      return null;
    }

    final requestId = ++_playRequestId;

    _activeRadioId = radio.id;
    _isPlaying = false;
    notifyListeners();

    try {
      await _player.setUrl(radio.uri);

      if (requestId != _playRequestId) return null;

      unawaited(_player.play());
      return null;
    } catch (error) {
      debugPrint('Radio play failed: $error');

      if (requestId == _playRequestId) {
        _resetPlayback();
      }

      return 'This radio station is not available right now.';
    }
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _player.setVolume(_isMuted ? 0 : 1);
    notifyListeners();
  }

  void _onPlayerState(PlayerState state) {
    final isPlaying = state.playing &&
        state.processingState != ProcessingState.completed;

    var changed = _isPlaying != isPlaying;
    _isPlaying = isPlaying;

    if (state.processingState == ProcessingState.completed) {
      _activeRadioId = null;
      changed = true;
    }

    if (changed) notifyListeners();
  }

  void _resetPlayback() {
    _activeRadioId = null;
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _playerErrorSubscription.cancel();
    unawaited(_player.dispose());
    super.dispose();
  }
}