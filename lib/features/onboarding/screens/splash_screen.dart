import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/extensions/context_extensions.dart';
import '../../../music/presentation/providers/music_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Pre-fetch home feed in background while splash animation runs
    _initAppAndNavigate();
  }

  Future<void> _initAppAndNavigate() async {
    // Start pre-fetching home feed in parallel
    try {
      ref.read(homeFeedProvider('hindi'));
    } catch (_) {}

    bool onboardingCompleted = false;
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final flagFile = File(p.join(docDir.path, 'onboarding_completed.flag'));
      onboardingCompleted = await flagFile.exists();
    } catch (_) {}

    // Show splash screen for 1.8 seconds
    await Future.delayed(const Duration(milliseconds: 1800));

    if (mounted) {
      if (onboardingCompleted) {
        context.go('/');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // GenZ Neon Mesh Gradient Orbs
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF2A85).withOpacity(0.40),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF2A85).withOpacity(0.40),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8A2BE2).withOpacity(0.45),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8A2BE2).withOpacity(0.45),
                    blurRadius: 110,
                    spreadRadius: 25,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: -30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00F5D4).withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00F5D4).withOpacity(0.25),
                    blurRadius: 90,
                    spreadRadius: 15,
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // GenZ Neon Holographic Glowing Logo Core
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF2A85),
                                Color(0xFF8A2BE2),
                                Color(0xFF00F5D4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF2A85).withOpacity(0.55),
                                blurRadius: 40,
                                spreadRadius: 8,
                              ),
                              BoxShadow(
                                color: const Color(0xFF00F5D4).withOpacity(0.35),
                                blurRadius: 60,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.40),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.graphic_eq_rounded,
                                size: 68,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),

                        // GenZ Stylized Brand Title
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFFFFFFF),
                              Color(0xFFFF77BC),
                              Color(0xFF00F5D4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'RAAGA',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Glassmorphic Tagline Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.18),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                '🎧  Pure Vibe • Main Character Energy  ✨',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 54),

                        // Sleek GenZ Soundwave Pulse Bars Loader
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            final heights = [18.0, 32.0, 48.0, 32.0, 18.0];
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300 + (index * 100)),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: 4,
                              height: heights[index],
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? const Color(0xFFFF2A85)
                                    : const Color(0xFF00F5D4),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: (index % 2 == 0
                                            ? const Color(0xFFFF2A85)
                                            : const Color(0xFF00F5D4))
                                        .withOpacity(0.8),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
