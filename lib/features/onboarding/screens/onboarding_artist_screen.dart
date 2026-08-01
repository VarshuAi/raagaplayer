import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_tokens/spacing.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/constants/urls.dart';
import '../../../music/presentation/providers/music_providers.dart';
import 'onboarding_curation_screen.dart';

class OnboardingArtistScreen extends ConsumerStatefulWidget {
  final List<String> selectedLanguages;

  const OnboardingArtistScreen({
    super.key,
    required this.selectedLanguages,
  });

  @override
  ConsumerState<OnboardingArtistScreen> createState() => _OnboardingArtistScreenState();
}

class _OnboardingArtistScreenState extends ConsumerState<OnboardingArtistScreen> {
  final Set<String> _selectedArtistIds = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> _dynamicArtists = [];
  bool _isLoading = true;

  static const List<Map<String, String>> _defaultArtists = [
    {'id': '459320', 'name': 'Arijit Singh', 'imageUrl': 'https://c.saavncdn.com/artists/Arijit_Singh_002_20230323062147_500x500.jpg'},
    {'id': '456863', 'name': 'Alka Yagnik', 'imageUrl': 'https://c.saavncdn.com/artists/Alka_Yagnik_500x500.jpg'},
    {'id': '456312', 'name': 'Pritam', 'imageUrl': 'https://c.saavncdn.com/artists/Pritam_500x500.jpg'},
    {'id': '455125', 'name': 'Udit Narayan', 'imageUrl': 'https://c.saavncdn.com/artists/Udit_Narayan_500x500.jpg'},
    {'id': '882797', 'name': 'Jubin Nautiyal', 'imageUrl': 'https://c.saavncdn.com/artists/Jubin_Nautiyal_500x500.jpg'},
    {'id': '455109', 'name': 'Kumar Sanu', 'imageUrl': 'https://c.saavncdn.com/artists/Kumar_Sanu_500x500.jpg'},
    {'id': '456863_s', 'name': 'Shreya Ghoshal', 'imageUrl': 'https://c.saavncdn.com/artists/Shreya_Ghoshal_004_20230221102919_500x500.jpg'},
    {'id': '455130', 'name': 'Sonu Nigam', 'imageUrl': 'https://c.saavncdn.com/artists/Sonu_Nigam_003_20230324103138_500x500.jpg'},
    {'id': '467576', 'name': 'Sidhu Moose Wala', 'imageUrl': 'https://c.saavncdn.com/artists/Sidhu_Moose_Wala_500x500.jpg'},
    {'id': '464936', 'name': 'Diljit Dosanjh', 'imageUrl': 'https://c.saavncdn.com/artists/Diljit_Dosanjh_500x500.jpg'},
    {'id': '792415', 'name': 'Karan Aujla', 'imageUrl': 'https://c.saavncdn.com/artists/Karan_Aujla_500x500.jpg'},
    {'id': '3430485', 'name': 'Shubh', 'imageUrl': 'https://c.saavncdn.com/artists/Shubh_500x500.jpg'},
    {'id': '456333', 'name': 'Anirudh Ravichander', 'imageUrl': 'https://c.saavncdn.com/artists/Anirudh_Ravichander_500x500.jpg'},
    {'id': '456314', 'name': 'A. R. Rahman', 'imageUrl': 'https://c.saavncdn.com/artists/A_R_Rahman_500x500.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchLanguageArtists();
  }

  Future<void> _fetchLanguageArtists() async {
    try {
      final client = ref.read(httpClientProvider);
      final queryLangs = widget.selectedLanguages.join(',');
      final uri = Uri.parse('${AppUrls.baseApiUrl}/api/home/onboarding/artists?languages=$queryLangs');
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        final parsed = list.map((a) => {
          'id': (a['id'] ?? '').toString(),
          'name': (a['name'] ?? 'Artist').toString(),
          'imageUrl': (a['imageUrl'] ?? '').toString(),
        }).where((a) => a['id']!.isNotEmpty).toList();

        if (mounted && parsed.isNotEmpty) {
          setState(() {
            _dynamicArtists.clear();
            _dynamicArtists.addAll(parsed);
            _isLoading = false;
          });
          return;
        }
      }
    } catch (e) {
      print('Onboarding Artists Error: $e');
    }

    if (mounted) {
      setState(() {
        _dynamicArtists.clear();
        _dynamicArtists.addAll(_defaultArtists);
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleArtist(String id) {
    setState(() {
      if (_selectedArtistIds.contains(id)) {
        _selectedArtistIds.remove(id);
      } else {
        _selectedArtistIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final artistSource = _dynamicArtists.isNotEmpty ? _dynamicArtists : _defaultArtists;
    final filteredArtists = artistSource.where((artist) {
      if (_searchQuery.isEmpty) return true;
      return artist['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Choose artists you like',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: context.colorScheme.onSurface),
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search artist...',
                  hintStyle: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.40)),
                  prefixIcon: Icon(Icons.search_rounded, color: context.colorScheme.onSurface.withOpacity(0.60)),
                  filled: true,
                  fillColor: context.colorScheme.surfaceContainerHigh,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap to select 2 or more',
              style: TextStyle(
                color: context.colorScheme.onSurface.withOpacity(0.50),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.82,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredArtists.length,
                      itemBuilder: (context, index) {
                        final artist = filteredArtists[index];
                        final isSelected = _selectedArtistIds.contains(artist['id']);

                        return GestureDetector(
                          onTap: () => _toggleArtist(artist['id']!),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? context.colorScheme.primary : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        artist['imageUrl']!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          color: context.colorScheme.surfaceContainerHigh,
                                          child: const Icon(Icons.person_rounded, size: 40),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.colorScheme.primary.withOpacity(0.45),
                                      ),
                                      child: const Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                artist['name']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface,
                                ),
                              ),
                            ],
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
                    '${_selectedArtistIds.length} Selected',
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
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => OnboardingCurationScreen(
                              languages: widget.selectedLanguages,
                              artistIds: _selectedArtistIds.toList(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Done',
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
