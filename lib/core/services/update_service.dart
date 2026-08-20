import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import '../extensions/context_extensions.dart';
import '../design_tokens/spacing.dart';

class UpdateService {
  static const String currentVersion = "2.0.0";
  static const int currentBuildNumber = 200;

  static const String updateInfoUrl =
      "https://raw.githubusercontent.com/VarshuAi/raagaplayer/main/release-info.json";

  static const _platform = MethodChannel('com.raaga.music/updater');

  /// Checks if a new update is available.
  static Future<Map<String, dynamic>?> checkForUpdates() async {
    if (!Platform.isAndroid) return null;
    try {
      final response = await http.get(Uri.parse(updateInfoUrl)).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final String remoteVersion = data['version'] as String? ?? "1.0.0";
        final int remoteBuild = data['buildNumber'] as int? ?? 1;

        if (_isNewerVersion(currentVersion, remoteVersion) || remoteBuild > currentBuildNumber) {
          return data;
        }
      }
    } catch (e) {
      print('[UpdateService] Update check failed: $e');
    }
    return null;
  }

  static bool _isNewerVersion(String local, String remote) {
    try {
      final localParts = local.split('.').map(int.parse).toList();
      final remoteParts = remote.split('.').map(int.parse).toList();

      for (int i = 0; i < 3; i++) {
        final lVal = i < localParts.length ? localParts[i] : 0;
        final rVal = i < remoteParts.length ? remoteParts[i] : 0;
        if (rVal > lVal) return true;
        if (lVal > rVal) return false;
      }
    } catch (_) {}
    return false;
  }

  static void showUpdateDialog(BuildContext context, Map<String, dynamic> updateInfo) {
    final version = updateInfo['version'] as String? ?? 'New';
    final notes = updateInfo['releaseNotes'] as String? ?? 'Bug fixes and performance improvements.';
    final apkUrl = updateInfo['apkUrl'] as String? ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => _UpdateDialogWidget(
        version: version,
        releaseNotes: notes,
        apkUrl: apkUrl,
      ),
    );
  }

  /// Checks if the app was just updated, and shows the "What's New" popup if true.
  static Future<void> checkAndShowPostUpdateDialog(BuildContext context) async {
    if (!Platform.isAndroid) return;
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final versionFile = File(p.join(docDir.path, 'last_run_version.txt'));
      
      String lastRunVersion = "";
      if (await versionFile.exists()) {
        lastRunVersion = (await versionFile.readAsString()).trim();
      }

      // If empty, save current version and exit (either fresh install or first run)
      if (lastRunVersion.isEmpty) {
        await versionFile.writeAsString(currentVersion);
        return;
      }

      // If the saved version is older/different than the current running version
      if (lastRunVersion != currentVersion) {
        await versionFile.writeAsString(currentVersion);

        // Fetch release notes from GitHub to show what was changed
        final updateInfo = await _checkForUpdatesQuietly();
        final notes = updateInfo?['releaseNotes'] as String? ?? 
            "• Autoplay recommendations matched with YT Music.\n• Pull-to-refresh home feed randomization.\n• Play Queue refresh recommendations button.";

        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => _WhatsNewDialogWidget(
              version: currentVersion,
              releaseNotes: notes,
            ),
          );
        }
      }
    } catch (e) {
      print('[UpdateService] Failed to check post-update status: $e');
    }
  }

  static Future<Map<String, dynamic>?> _checkForUpdatesQuietly() async {
    try {
      final response = await http.get(Uri.parse(updateInfoUrl)).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  /// Triggers the native installation of the APK file
  static Future<bool> installApk(String filePath) async {
    try {
      final bool success = await _platform.invokeMethod('installApk', {'filePath': filePath});
      return success;
    } on PlatformException catch (e) {
      print('[UpdateService] Native installation failed: ${e.message}');
      return false;
    }
  }
}

class _UpdateDialogWidget extends StatefulWidget {
  final String version;
  final String releaseNotes;
  final String apkUrl;

  const _UpdateDialogWidget({
    required this.version,
    required this.releaseNotes,
    required this.apkUrl,
  });

  @override
  State<_UpdateDialogWidget> createState() => _UpdateDialogWidgetState();
}

class _UpdateDialogWidgetState extends State<_UpdateDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _statusText = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startDownloadAndInstall() async {
    if (widget.apkUrl.isEmpty) return;

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _statusText = "Connecting...";
    });

    try {
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(widget.apkUrl));
      final response = await client.send(request).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Server returned code ${response.statusCode}');
      }

      final contentLength = response.contentLength ?? 28 * 1024 * 1024;
      final bytes = <int>[];
      int downloaded = 0;

      final tempDir = await getTemporaryDirectory();
      final apkPath = p.join(tempDir.path, 'raaga_update.apk');
      final apkFile = File(apkPath);
      if (await apkFile.exists()) {
        await apkFile.delete();
      }

      final IOSink sink = apkFile.openWrite();

      await for (final List<int> chunk in response.stream) {
        sink.add(chunk);
        downloaded += chunk.length;
        setState(() {
          _downloadProgress = downloaded / contentLength;
          _statusText = "Downloading update... ${((downloaded / (1024 * 1024)).toStringAsFixed(1))} MB";
        });
      }

      await sink.close();
      client.close();

      setState(() {
        _statusText = "Launching package installer...";
        _downloadProgress = 1.0;
      });

      final success = await UpdateService.installApk(apkPath);
      if (!success && mounted) {
        final uri = Uri.parse(widget.apkUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('[UpdateDialog] In-app download failed: $e');
      setState(() {
        _statusText = "Download failed. Redirecting to browser...";
      });
      await Future.delayed(const Duration(seconds: 2));
      final uri = Uri.parse(widget.apkUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: primary.withOpacity(0.12),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SafeArea(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [primary, secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.system_update_alt_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Update Available! 🎉',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Version v${widget.version}',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (!_isDownloading) ...[
                Text(
                  'What\'s New:',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.colorScheme.outline.withOpacity(0.1),
                    ),
                  ),
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      widget.releaseNotes,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: context.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Later',
                          style: TextStyle(
                            color: context.colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _startDownloadAndInstall,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Update Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(
                _statusText,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _downloadProgress,
                  minHeight: 10,
                  backgroundColor: context.colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${(_downloadProgress * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    ),
  );
}
}

class _WhatsNewDialogWidget extends StatelessWidget {
  final String version;
  final String releaseNotes;

  const _WhatsNewDialogWidget({
    required this.version,
    required this.releaseNotes,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: primary.withOpacity(0.12),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header with celebration looks
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [primary, secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What\'s New in Raaga! 🌟',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Successfully updated to v$version',
                        style: TextStyle(
                          color: context.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Change log info list
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.colorScheme.outline.withOpacity(0.1),
                ),
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  releaseNotes,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.6,
                    color: context.colorScheme.onSurface.withOpacity(0.85),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),

            // Got it button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Awesome!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
