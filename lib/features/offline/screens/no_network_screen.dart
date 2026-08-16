import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../download/presentation/screens/download_manager_screen.dart';

/// Checks internet by doing a DNS lookup — no external plugin needed.
Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('music.youtube.com')
        .timeout(const Duration(seconds: 3));
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

/// Shown when there is no internet connection.
/// Polls every 3 seconds and auto-dismisses when connectivity is restored.
class NoNetworkScreen extends ConsumerStatefulWidget {
  const NoNetworkScreen({super.key});

  @override
  ConsumerState<NoNetworkScreen> createState() => _NoNetworkScreenState();
}

class _NoNetworkScreenState extends ConsumerState<NoNetworkScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.85, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Poll every 3 seconds — pop back when internet returns
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final online = await hasInternetConnection();
      if (online && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pulsing wifi-off icon
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (context, _) => Transform.scale(
                  scale: _pulseAnim.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          primary.withOpacity(0.25),
                          secondary.withOpacity(0.12),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 58,
                      color: primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'No Internet',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'You\'re offline. Streaming isn\'t available, but your downloaded songs are ready to play!',
                style: TextStyle(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Go to Downloads button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const DownloadManagerScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_done_rounded, size: 22),
                  label: const Text(
                    'Play Offline Music',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Auto-check indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primary.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Checking every 3 seconds...',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
