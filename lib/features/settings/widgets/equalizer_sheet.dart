import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/sheets/raaga_bottom_sheet.dart';
import '../../../../core/audio/audio_effects.dart';
import '../../../../core/playback/playback_engine.dart';

class EqualizerSheet extends ConsumerStatefulWidget {
  const EqualizerSheet({super.key});

  @override
  ConsumerState<EqualizerSheet> createState() => _EqualizerSheetState();
}

class _EqualizerSheetState extends ConsumerState<EqualizerSheet> {
  final _effectsManager = AudioEffectsManager();
  bool _isEnabled = false;
  double _bassBoost = 0.0;
  List<AndroidEqualizerBand> _bands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isEnabled = _effectsManager.equalizerEnabled;
    _bassBoost = _effectsManager.bassBoostLevel;
    _loadBands();
  }

  Future<void> _loadBands() async {
    if (Platform.isAndroid) {
      try {
        final params = await PlaybackEngine.androidEqualizer.parameters;
        setState(() {
          _bands = params.bands;
          _isLoading = false;
        });
        return;
      } catch (_) {}
    }
    setState(() => _isLoading = false);
  }

  void _onPresetSelected(String preset) {
    if (!_isEnabled) return;
    // Map of common presets
    final Map<String, List<double>> presets = {
      'Flat': [0.0, 0.0, 0.0, 0.0, 0.0],
      'Bass Boost': [8.0, 5.0, 0.0, 0.0, 0.0],
      'Vocal Boost': [-2.0, 0.0, 4.0, 5.0, 2.0],
      'Rock': [5.0, 3.0, -1.0, 2.0, 4.0],
      'Pop': [-1.0, 2.0, 5.0, 1.0, -2.0],
      'Lofi': [4.0, 1.0, -3.0, -1.0, -4.0],
    };

    final gains = presets[preset];
    if (gains != null) {
      for (int i = 0; i < gains.length && i < _bands.length; i++) {
        _effectsManager.setEqualizerBand(i, gains[i]);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaagaBottomSheet(
      title: 'Audio Equalizer',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enable/Disable switch row
          SwitchListTile(
            title: Text(
              'Enable Equalizer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              'Apply custom frequency balance presets',
              style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.6)),
            ),
            value: _isEnabled,
            onChanged: (val) async {
              await _effectsManager.enableEqualizer(val);
              setState(() => _isEnabled = val);
            },
            activeColor: context.colorScheme.primary,
          ),
          const Divider(),

          // Preset Chips Row
          if (_isEnabled) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Presets',
                style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: ['Flat', 'Bass Boost', 'Vocal Boost', 'Rock', 'Pop', 'Lofi'].map((preset) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(preset),
                      onPressed: () => _onPresetSelected(preset),
                      backgroundColor: context.colorScheme.surfaceContainerHigh,
                      labelStyle: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Bass Boost slider
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bass Boost',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isEnabled ? context.colorScheme.onSurface : context.colorScheme.onSurface.withOpacity(0.38),
                  ),
                ),
                Text(
                  '${(_bassBoost * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: _isEnabled ? context.colorScheme.primary : context.colorScheme.onSurface.withOpacity(0.38),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Slider(
              value: _bassBoost,
              onChanged: _isEnabled
                  ? (val) {
                      _effectsManager.setBassBoost(val);
                      setState(() => _bassBoost = val);
                    }
                  : null,
              activeColor: context.colorScheme.primary,
            ),
          ),
          const Divider(),

          // Bands sliders
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            )
          else if (!Platform.isAndroid)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Platform Equalizer is only supported on Android devices.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
            )
          else if (_bands.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'No Equalizer hardware detected on this device.',
                  style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.6)),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Frequency Bands (dB)',
                      style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...List.generate(_bands.length, (idx) {
                    final band = _bands[idx];
                    final hz = (band.centerFrequency).round();
                    final gain = _effectsManager.equalizerBands[idx] ?? band.gain;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 64,
                            child: Text(
                              hz >= 1000 ? '${(hz / 1000).toStringAsFixed(1)} kHz' : '$hz Hz',
                              style: TextStyle(
                                fontSize: 13,
                                color: _isEnabled ? context.colorScheme.onSurface : context.colorScheme.onSurface.withOpacity(0.38),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              min: -15.0,
                              max: 15.0,
                              value: gain,
                              onChanged: _isEnabled
                                  ? (val) {
                                      _effectsManager.setEqualizerBand(idx, val);
                                      setState(() {});
                                    }
                                  : null,
                              activeColor: context.colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: 48,
                            child: Text(
                              '${gain > 0 ? "+" : ""}${gain.toStringAsFixed(1)} dB',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 11,
                                color: _isEnabled ? context.colorScheme.primary : context.colorScheme.onSurface.withOpacity(0.38),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
