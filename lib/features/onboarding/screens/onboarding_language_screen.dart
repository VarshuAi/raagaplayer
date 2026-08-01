import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import 'onboarding_artist_screen.dart';

class OnboardingLanguageScreen extends ConsumerStatefulWidget {
  const OnboardingLanguageScreen({super.key});

  @override
  ConsumerState<OnboardingLanguageScreen> createState() => _OnboardingLanguageScreenState();
}

class _OnboardingLanguageScreenState extends ConsumerState<OnboardingLanguageScreen> {
  final TextEditingController _nameController = TextEditingController();
  final Set<String> _selectedLanguages = {'hindi'};

  final List<Map<String, String>> _languages = [
    {'id': 'hindi', 'name': 'Hindi', 'native': 'हिंदी', 'artistUrl': 'https://c.saavncdn.com/artists/Arijit_Singh_002_20230323062147_500x500.jpg'},
    {'id': 'english', 'name': 'English', 'native': 'English', 'artistUrl': 'https://c.saavncdn.com/artists/Taylor_Swift_500x500.jpg'},
    {'id': 'punjabi', 'name': 'Punjabi', 'native': 'ਪੰਜਾਬੀ', 'artistUrl': 'https://c.saavncdn.com/artists/Diljit_Dosanjh_500x500.jpg'},
    {'id': 'tamil', 'name': 'Tamil', 'native': 'தமிழ்', 'artistUrl': 'https://c.saavncdn.com/artists/Anirudh_Ravichander_500x500.jpg'},
    {'id': 'telugu', 'name': 'Telugu', 'native': 'తెలుగు', 'artistUrl': 'https://c.saavncdn.com/artists/Devi_Sri_Prasad_500x500.jpg'},
    {'id': 'marathi', 'name': 'Marathi', 'native': 'मराठी', 'artistUrl': 'https://c.saavncdn.com/artists/Pritam_500x500.jpg'},
    {'id': 'gujarati', 'name': 'Gujarati', 'native': 'ગુજરાતી', 'artistUrl': 'https://c.saavncdn.com/artists/Alka_Yagnik_500x500.jpg'},
    {'id': 'bengali', 'name': 'Bengali', 'native': 'বাংলা', 'artistUrl': 'https://c.saavncdn.com/artists/Shreya_Ghoshal_004_20230221102919_500x500.jpg'},
    {'id': 'kannada', 'name': 'Kannada', 'native': 'ಕನ್ನಡ', 'artistUrl': 'https://c.saavncdn.com/artists/Vijay_Prakash_007_20250225123208_500x500.jpg'},
    {'id': 'bhojpuri', 'name': 'Bhojpuri', 'native': 'भोजपुरी', 'artistUrl': 'https://c.saavncdn.com/artists/Khesari_Lal_Yadav_004_20241119074533_500x500.jpg'},
    {'id': 'malayalam', 'name': 'Malayalam', 'native': 'മലയാളം', 'artistUrl': 'https://c.saavncdn.com/artists/Sushin_Shyam_002_20250707125538_500x500.jpg'},
    {'id': 'sanskrit', 'name': 'Sanskrit', 'native': 'संस्कृत', 'artistUrl': 'https://c.saavncdn.com/artists/Lata_Mangeshkar_500x500.jpg'},
    {'id': 'haryanvi', 'name': 'Haryanvi', 'native': 'हरियाणवी', 'artistUrl': 'https://c.saavncdn.com/artists/Dhanda_Nyoliwala_000_20240820133551_500x500.jpg'},
    {'id': 'rajasthani', 'name': 'Rajasthani', 'native': 'राजस्थानी', 'artistUrl': 'https://c.saavncdn.com/artists/Kumar_Sanu_500x500.jpg'},
    {'id': 'odia', 'name': 'Odia', 'native': 'ଓଡ଼ିଆ', 'artistUrl': 'https://c.saavncdn.com/artists/Udit_Narayan_500x500.jpg'},
    {'id': 'assamese', 'name': 'Assamese', 'native': 'অসমীয়া', 'artistUrl': 'https://c.saavncdn.com/artists/Sonu_Nigam_003_20230324103138_500x500.jpg'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleLanguage(String id) {
    setState(() {
      if (_selectedLanguages.contains(id)) {
        if (_selectedLanguages.length > 1) {
          _selectedLanguages.remove(id);
        }
      } else {
        _selectedLanguages.add(id);
      }
    });
  }

  Future<void> _saveLanguagesAndProceed({String? name}) async {
    final displayName = (name != null && name.trim().isNotEmpty) ? name.trim() : 'Music Lover';

    try {
      final docDir = await getApplicationDocumentsDirectory();
      final nameFile = File(p.join(docDir.path, 'user_name.txt'));
      await nameFile.writeAsString(displayName);

      final langFile = File(p.join(docDir.path, 'selected_languages.json'));
      await langFile.writeAsString(json.encode(_selectedLanguages.toList()));

      final flagFile = File(p.join(docDir.path, 'onboarding_completed.flag'));
      await flagFile.writeAsString('true');
    } catch (_) {}

    if (mounted) {
      context.go('/');
    }
  }

  void _showNamePromptDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('What should we call you?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: 'Enter your name...',
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.40)),
              prefixIcon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.primary),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _saveLanguagesAndProceed(name: 'Music Lover');
              },
              child: const Text('Skip'),
            ),
            FilledButton(
              onPressed: () {
                final input = controller.text.trim();
                Navigator.pop(ctx);
                _saveLanguagesAndProceed(name: input);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome to A1 Raaga! 🎵',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _saveLanguagesAndProceed(name: 'Music Lover'),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.60)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pick all the languages you want to listen to',
                  style: TextStyle(
                    color: context.colorScheme.onSurface.withOpacity(0.80),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  final isSelected = _selectedLanguages.contains(lang['id']);

                  return InkWell(
                    onTap: () => _toggleLanguage(lang['id']!),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colorScheme.primary.withOpacity(0.20)
                            : context.colorScheme.surfaceContainerHigh.withOpacity(0.60),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? context.colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -10,
                              bottom: -10,
                              width: 85,
                              height: 85,
                              child: Opacity(
                                opacity: isSelected ? 0.9 : 0.45,
                                child: Image.network(
                                  lang['artistUrl']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lang['native']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.white : context.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: context.colorScheme.primary,
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    lang['name']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.onSurface.withOpacity(0.60),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLow,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_selectedLanguages.length} Languages Selected',
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withOpacity(0.60),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: _showNamePromptDialog,
                      child: const Text(
                        'Save & Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
