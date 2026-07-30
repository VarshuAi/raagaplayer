class AppSettings {
  final String themeMode;
  final bool amoledMode;
  final bool dynamicColors;
  final double blurStrength;
  final double cornerRadius;
  final double fontScaling;
  final double crossfadeDurationSec;
  final bool gaplessPlayback;
  final bool resumePlayback;
  final bool scanOnStartup;
  final double hapticStrength;

  const AppSettings({
    this.themeMode = 'dark',
    this.amoledMode = true,
    this.dynamicColors = true,
    this.blurStrength = 1.0,
    this.cornerRadius = 1.0,
    this.fontScaling = 1.0,
    this.crossfadeDurationSec = 0.0,
    this.gaplessPlayback = true,
    this.resumePlayback = true,
    this.scanOnStartup = false,
    this.hapticStrength = 1.0,
  });

  AppSettings copyWith({
    String? themeMode,
    bool? amoledMode,
    bool? dynamicColors,
    double? blurStrength,
    double? cornerRadius,
    double? fontScaling,
    double? crossfadeDurationSec,
    bool? gaplessPlayback,
    bool? resumePlayback,
    bool? scanOnStartup,
    double? hapticStrength,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      amoledMode: amoledMode ?? this.amoledMode,
      dynamicColors: dynamicColors ?? this.dynamicColors,
      blurStrength: blurStrength ?? this.blurStrength,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      fontScaling: fontScaling ?? this.fontScaling,
      crossfadeDurationSec: crossfadeDurationSec ?? this.crossfadeDurationSec,
      gaplessPlayback: gaplessPlayback ?? this.gaplessPlayback,
      resumePlayback: resumePlayback ?? this.resumePlayback,
      scanOnStartup: scanOnStartup ?? this.scanOnStartup,
      hapticStrength: hapticStrength ?? this.hapticStrength,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode,
      'amoledMode': amoledMode,
      'dynamicColors': dynamicColors,
      'blurStrength': blurStrength,
      'cornerRadius': cornerRadius,
      'fontScaling': fontScaling,
      'crossfadeDurationSec': crossfadeDurationSec,
      'gaplessPlayback': gaplessPlayback,
      'resumePlayback': resumePlayback,
      'scanOnStartup': scanOnStartup,
      'hapticStrength': hapticStrength,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: json['themeMode'] ?? 'dark',
      amoledMode: json['amoledMode'] ?? true,
      dynamicColors: json['dynamicColors'] ?? true,
      blurStrength: (json['blurStrength'] ?? 1.0) as double,
      cornerRadius: (json['cornerRadius'] ?? 1.0) as double,
      fontScaling: (json['fontScaling'] ?? 1.0) as double,
      crossfadeDurationSec: (json['crossfadeDurationSec'] ?? 0.0) as double,
      gaplessPlayback: json['gaplessPlayback'] ?? true,
      resumePlayback: json['resumePlayback'] ?? true,
      scanOnStartup: json['scanOnStartup'] ?? false,
      hapticStrength: (json['hapticStrength'] ?? 1.0) as double,
    );
  }
}
