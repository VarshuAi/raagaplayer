import 'dart:async';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import '../playback/playback_engine.dart';

class AudioEffectsManager {
  static final AudioEffectsManager _instance = AudioEffectsManager._internal();
  factory AudioEffectsManager() => _instance;
  AudioEffectsManager._internal() {
    _initEqualizer();
  }

  bool _equalizerEnabled = false;
  double _bassBoostLevel = 0.0;
  double _crossfadeDurationSec = 0.0;
  final Map<int, double> _equalizerBands = {};

  bool get equalizerEnabled => _equalizerEnabled;
  double get bassBoostLevel => _bassBoostLevel;
  double get crossfadeDurationSec => _crossfadeDurationSec;
  Map<int, double> get equalizerBands => _equalizerBands;

  final _effectsChangedController = StreamController<void>.broadcast();
  Stream<void> get onEffectsChanged => _effectsChangedController.stream;

  Future<void> _initEqualizer() async {
    if (Platform.isAndroid) {
      try {
        final params = await PlaybackEngine.androidEqualizer.parameters;
        for (int i = 0; i < params.bands.length; i++) {
          _equalizerBands[i] = params.bands[i].gain;
        }
        _equalizerEnabled = await PlaybackEngine.androidEqualizer.enabled;
      } catch (e) {
        print('Error initializing equalizer parameters: $e');
      }
    }
  }

  Future<void> enableEqualizer(bool enable) async {
    _equalizerEnabled = enable;
    if (Platform.isAndroid) {
      try {
        await PlaybackEngine.androidEqualizer.setEnabled(enable);
      } catch (e) {
        print('Error enabling equalizer: $e');
      }
    }
    _effectsChangedController.add(null);
  }

  Future<void> setBassBoost(double level) async {
    _bassBoostLevel = level.clamp(0.0, 1.0);
    if (Platform.isAndroid) {
      try {
        final params = await PlaybackEngine.androidEqualizer.parameters;
        final maxBassDb = 12.0 * _bassBoostLevel;
        
        if (params.bands.isNotEmpty) {
          await params.bands[0].setGain(maxBassDb);
          _equalizerBands[0] = maxBassDb;
        }
        if (params.bands.length > 1) {
          await params.bands[1].setGain(maxBassDb * 0.7);
          _equalizerBands[1] = maxBassDb * 0.7;
        }
      } catch (e) {
        print('Error setting bass boost: $e');
      }
    }
    _effectsChangedController.add(null);
  }

  Future<void> setCrossfade(double durationSec) async {
    _crossfadeDurationSec = durationSec.clamp(0.0, 10.0);
    _effectsChangedController.add(null);
  }

  Future<void> setEqualizerBand(int bandIndex, double gainDb) async {
    _equalizerBands[bandIndex] = gainDb.clamp(-15.0, 15.0);
    if (Platform.isAndroid) {
      try {
        final params = await PlaybackEngine.androidEqualizer.parameters;
        if (bandIndex >= 0 && bandIndex < params.bands.length) {
          await params.bands[bandIndex].setGain(gainDb);
        }
      } catch (e) {
        print('Error setting equalizer band: $e');
      }
    }
    _effectsChangedController.add(null);
  }

  void dispose() {
    _effectsChangedController.close();
  }
}
