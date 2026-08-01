import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/insights_providers.dart';
import '../../../../core/extensions/context_extensions.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(playbackInsightsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Insights'),
        centerTitle: true,
      ),
      body: insightsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading stats: $err')),
        data: (data) {
          if (data.totalSongsPlayed == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.query_stats_rounded, size: 64, color: context.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    'No Playback Data Yet',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Play some music to generate your stats dashboard!',
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewCards(context, data),
                const SizedBox(height: 24),
                _buildSectionHeader(context, "Listening Profile"),
                const SizedBox(height: 12),
                _buildDetailList(context, data),
                const SizedBox(height: 24),
                _buildSectionHeader(context, "Your Favorites"),
                const SizedBox(height: 12),
                _buildFavoritesGrid(context, data),
                const SizedBox(height: 24),
                _buildSectionHeader(context, "Weekly Listening Patterns"),
                const SizedBox(height: 16),
                _buildWeeklyListeningChart(context, data.dailyListeningMinutes),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.primary,
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context, PlaybackInsightsData data) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            context,
            "Minutes Played",
            "${data.totalMinutes}m",
            Icons.timer_rounded,
            context.colorScheme.primaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            context,
            "Listening Streak",
            "${data.currentStreak} days",
            Icons.local_fire_department_rounded,
            Colors.orange.shade100,
            textColor: Colors.orange.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color bg, {
    Color? textColor,
  }) {
    return Card(
      elevation: 0,
      color: bg,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          children: [
            Icon(icon, size: 28, color: textColor ?? context.colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor ?? context.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: textColor?.withOpacity(0.8) ?? context.colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailList(BuildContext context, PlaybackInsightsData data) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow(context, "Songs Discovered", "${data.uniqueSongs} tracks", Icons.explore_rounded),
          const Divider(height: 1),
          _buildDetailRow(context, "Avg Session Length", "${data.averageSessionMinutes.toStringAsFixed(1)}m", Icons.av_timer_rounded),
          const Divider(height: 1),
          _buildDetailRow(context, "Skip Rate", "${(data.skipRate * 100).toStringAsFixed(1)}%", Icons.skip_next_rounded),
          const Divider(height: 1),
          _buildDetailRow(context, "Completion Rate", "${(data.averageCompletionRate * 100).toStringAsFixed(1)}%", Icons.done_all_rounded),
          const Divider(height: 1),
          _buildDetailRow(context, "Favorite Decade", data.favoriteDecade, Icons.calendar_today_rounded),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: context.colorScheme.primary),
      title: Text(label),
      trailing: Text(
        value,
        style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, PlaybackInsightsData data) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildFavoriteCard(context, "Favorite Song", data.topSong, Icons.music_note_rounded),
        _buildFavoriteCard(context, "Favorite Artist", data.topArtist, Icons.person_rounded),
        _buildFavoriteCard(context, "Favorite Album", data.topAlbum, Icons.album_rounded),
        _buildFavoriteCard(context, "Favorite Genre", data.topGenre, Icons.library_music_rounded),
      ],
    );
  }

  Widget _buildFavoriteCard(BuildContext context, String label, String value, IconData icon) {
    return Card(
      elevation: 0,
      color: context.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: context.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyListeningChart(BuildContext context, Map<String, int> dailyListening) {
    final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    final maxMinutes = dailyListening.values.fold(0, (max, element) => element > max ? element : max);

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: days.map((day) {
          final minutes = dailyListening[day] ?? 0;
          final heightRatio = maxMinutes > 0 ? (minutes / maxMinutes) : 0.0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                minutes > 0 ? "${minutes}m" : "",
                style: context.textTheme.bodySmall?.copyWith(fontSize: 9),
              ),
              const SizedBox(height: 4),
              Container(
                width: 20,
                height: heightRatio * 120 + 4, // minimum height of 4px
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                day.substring(0, 3),
                style: context.textTheme.bodySmall,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
