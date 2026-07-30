import 'dart:async';

class AudioEffectsManager {
  static final AudioEffectsManager _instance = AudioEffectsManager._internal();
  factory AudioEffectsManager() => _instance;
  AudioEffectsManager._internal();

  bool _equalizerEnabled = false;
  double _bassBoostLevel = 0.0;
  double _crossfadeDurationSec = 0.0;
  Map<int, double> _equalizerBands = {};

  bool get equalizerEnabled => _equalizerEnabled;
  double get bassBoostLevel => _bassBoostLevel;
  double get crossfadeDurationSec => _crossfadeDurationSec;
  Map<int, double> get equalizerBands => _equalizerBands;

  final _effectsChangedController = StreamController<void>.broadcast();
  Stream<void> get onEffectsChanged => _effectsChangedController.stream;

  Future<void> enableEqualizer(bool enable) async {
    _equalizerEnabled = enable;
    _effectsChangedController.add(null);
  }

  Future<void> setBassBoost(double level) async {
    _bassBoostLevel = level.clamp(0.0, 1.0);
    _effectsChangedController.add(null);
  }

  Future<void> setCrossfade(double durationSec) async {
    _crossfadeDurationSec = durationSec.clamp(0.0, 10.0);
    _effectsChangedController.add(null);
  }

  Future<void> setEqualizerBand(int frequencyHz, double gainDb) async {
    _equalizerBands[frequencyHz] = gainDb.clamp(-15.0, 15.0);
    _effectsChangedController.add(null);
  }

  void dispose() {
    _effectsChangedController.close();
  }
}
