import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/indicators/raaga_indicators.dart';
import '../../../music/data/datasource/remote/ytmusic_client.dart';
import '../../../music/presentation/providers/music_providers.dart';
import 'artist_page.dart';

// ── Curated artist lists per language ────────────────────────────────────────
const _langArtists = <String, List<Map<String, String>>>{
  'hindi': [
    {'name': 'Arijit Singh', 'emoji': '🎤'},
    {'name': 'Jubin Nautiyal', 'emoji': '🎵'},
    {'name': 'Neha Kakkar', 'emoji': '💃'},
    {'name': 'Atif Aslam', 'emoji': '🎸'},
    {'name': 'Sonu Nigam', 'emoji': '🎙️'},
    {'name': 'Shreya Ghoshal', 'emoji': '🌸'},
    {'name': 'Armaan Malik', 'emoji': '🎤'},
    {'name': 'KK', 'emoji': '🎵'},
    {'name': 'Udit Narayan', 'emoji': '🎶'},
    {'name': 'Kumar Sanu', 'emoji': '🎸'},
    {'name': 'Lata Mangeshkar', 'emoji': '👑'},
    {'name': 'Mohammed Rafi', 'emoji': '🌟'},
  ],
  'punjabi': [
    {'name': 'Diljit Dosanjh', 'emoji': '🎤'},
    {'name': 'AP Dhillon', 'emoji': '🎵'},
    {'name': 'Sidhu Moosewala', 'emoji': '👑'},
    {'name': 'Guru Randhawa', 'emoji': '🎸'},
    {'name': 'Babbal Rai', 'emoji': '🎶'},
    {'name': 'Mankirt Aulakh', 'emoji': '🔥'},
    {'name': 'Karan Aujla', 'emoji': '🎤'},
    {'name': 'Ammy Virk', 'emoji': '🎵'},
    {'name': 'Hardy Sandhu', 'emoji': '💫'},
    {'name': 'Jasmine Sandlas', 'emoji': '💃'},
  ],
  'tamil': [
    {'name': 'AR Rahman', 'emoji': '🎹'},
    {'name': 'Yuvan Shankar Raja', 'emoji': '🎵'},
    {'name': 'Sid Sriram', 'emoji': '🎤'},
    {'name': 'Anirudh Ravichander', 'emoji': '🔥'},
    {'name': 'Dhanush', 'emoji': '🌟'},
    {'name': 'Ilaiyaraaja', 'emoji': '👑'},
    {'name': 'Vijay Antony', 'emoji': '🎸'},
    {'name': 'Karthik', 'emoji': '🎤'},
  ],
  'telugu': [
    {'name': 'SS Thaman', 'emoji': '🎹'},
    {'name': 'Devi Sri Prasad', 'emoji': '🔥'},
    {'name': 'MM Keeravaani', 'emoji': '🌟'},
    {'name': 'Sid Sriram', 'emoji': '🎤'},
    {'name': 'Armaan Malik', 'emoji': '💫'},
    {'name': 'Mangli', 'emoji': '💃'},
  ],
  'kannada': [
    {'name': 'Vijay Prakash', 'emoji': '🎤'},
    {'name': 'Rajesh Krishnan', 'emoji': '🎵'},
    {'name': 'Ananya Bhat', 'emoji': '💃'},
    {'name': 'Hamsalekha', 'emoji': '🎸'},
    {'name': 'Arjun Janya', 'emoji': '🎹'},
  ],
  'malayalam': [
    {'name': 'K.J. Yesudas', 'emoji': '👑'},
    {'name': 'KS Chithra', 'emoji': '🌸'},
    {'name': 'Vineeth Sreenivasan', 'emoji': '🎤'},
    {'name': 'Sithara Krishnakumar', 'emoji': '💃'},
    {'name': 'Gopi Sundar', 'emoji': '🎹'},
  ],
  'marathi': [
    {'name': 'Shreya Ghoshal', 'emoji': '🌸'},
    {'name': 'Shankar Mahadevan', 'emoji': '🎤'},
    {'name': 'Ajay-Atul', 'emoji': '🎵'},
    {'name': 'Vaishali Samant', 'emoji': '💃'},
  ],
  'bhojpuri': [
    {'name': 'Pawan Singh', 'emoji': '🎤'},
    {'name': 'Khesari Lal Yadav', 'emoji': '🎵'},
    {'name': 'Nirahua', 'emoji': '🎸'},
    {'name': 'Ritesh Pandey', 'emoji': '🌟'},
  ],
  'bengali': [
    {'name': 'Arijit Singh', 'emoji': '🎤'},
    {'name': 'Nachiketa Chakraborty', 'emoji': '🎸'},
    {'name': 'Usha Uthup', 'emoji': '👑'},
    {'name': 'Manna Dey', 'emoji': '🌟'},
  ],
  'english': [
    {'name': 'The Weeknd', 'emoji': '🎤'},
    {'name': 'Taylor Swift', 'emoji': '✨'},
    {'name': 'Ed Sheeran', 'emoji': '🎸'},
    {'name': 'Dua Lipa', 'emoji': '💃'},
    {'name': 'Coldplay', 'emoji': '🎵'},
    {'name': 'Billie Eilish', 'emoji': '🌙'},
    {'name': 'Drake', 'emoji': '🔥'},
    {'name': 'Ariana Grande', 'emoji': '🌸'},
  ],
};

// ── Artists Browser Page ──────────────────────────────────────────────────────
class ArtistsBrowserPage extends ConsumerStatefulWidget {
  final Set<String> selectedLanguages;
  const ArtistsBrowserPage({super.key, required this.selectedLanguages});

  @override
  ConsumerState<ArtistsBrowserPage> createState() => _ArtistsBrowserPageState();
}

class _ArtistsBrowserPageState extends ConsumerState<ArtistsBrowserPage> {
  late String _activeLang;

  @override
  void initState() {
    super.initState();
    _activeLang = widget.selectedLanguages.isNotEmpty
        ? widget.selectedLanguages.first
        : 'hindi';
  }

  List<Map<String, String>> get _artists {
    return _langArtists[_activeLang] ?? _langArtists['hindi']!;
  }

  List<String> get _availableLangs {
    return _langArtists.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Browse Artists',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language filter chips
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: _availableLangs.length,
              itemBuilder: (context, i) {
                final lang = _availableLangs[i];
                final cap = lang[0].toUpperCase() + lang.substring(1);
                final isSelected = lang == _activeLang;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cap),
                    selected: isSelected,
                    selectedColor: primary,
                    backgroundColor: context.colorScheme.surfaceContainerHigh,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : context.colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onSelected: (_) => setState(() => _activeLang = lang),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Artist grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              itemCount: _artists.length,
              itemBuilder: (context, index) {
                final artist = _artists[index];
                return _ArtistCard(
                  name: artist['name']!,
                  emoji: artist['emoji']!,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ArtistPage(artistName: artist['name']!),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Artist Card ───────────────────────────────────────────────────────────────
class _ArtistCard extends StatelessWidget {
  final String name;
  final String emoji;
  final VoidCallback onTap;

  const _ArtistCard({
    required this.name,
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final secondary = context.colorScheme.secondary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  primary.withOpacity(0.8),
                  secondary.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 34)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
