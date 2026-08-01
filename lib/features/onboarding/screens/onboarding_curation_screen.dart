import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/extensions/context_extensions.dart';

class OnboardingCurationScreen extends ConsumerStatefulWidget {
  final List<String> languages;
  final List<String> artistIds;

  const OnboardingCurationScreen({
    super.key,
    required this.languages,
    required this.artistIds,
  });

  @override
  ConsumerState<OnboardingCurationScreen> createState() => _OnboardingCurationScreenState();
}

class _OnboardingCurationScreenState extends ConsumerState<OnboardingCurationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Save preferences and navigate to main home screen after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () async {
      try {
        final docDir = await getApplicationDocumentsDirectory();
        final flagFile = File(p.join(docDir.path, 'onboarding_completed.flag'));
        await flagFile.writeAsString('1');
      } catch (_) {}

      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 0.88, end: 1.12).animate(
                CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
              ),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.secondary,
                      context.colorScheme.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.music_note_rounded,
                  color: Colors.white,
                  size: 54,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Curating Music, JioTunes &\nPodcasts just For You',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
