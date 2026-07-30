import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/sheets/raaga_bottom_sheet.dart';
import '../../../core/extensions/context_extensions.dart';
import '../provider/sleep_timer_provider.dart';

class SleepTimerSheet extends ConsumerWidget {
  const SleepTimerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(sleepTimerProvider);
    final timerNotifier = ref.read(sleepTimerProvider.notifier);

    final timerOptions = {
      '15 minutes': const Duration(minutes: 15),
      '30 minutes': const Duration(minutes: 30),
      '45 minutes': const Duration(minutes: 45),
      '1 hour': const Duration(hours: 1),
    };

    return RaagaBottomSheet(
      title: 'Sleep Timer',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (timerState.isActive && timerState.remainingTime != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Timer active: ${_formatDuration(timerState.remainingTime!)} remaining',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cancel_rounded, color: Colors.red),
              title: const Text('Cancel Active Timer', style: TextStyle(color: Colors.red)),
              onTap: () {
                timerNotifier.cancelTimer();
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
          ],
          ...timerOptions.entries.map((e) {
            return ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: Text(e.key),
              onTap: () {
                timerNotifier.startTimer(e.value);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return "$m:${s < 10 ? '0' : ''}$s";
  }
}
