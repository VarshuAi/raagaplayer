import 'package:flutter/material.dart';
import 'crash_reporter.dart';
import 'performance_monitor.dart';

class DevConsoleScreen extends StatefulWidget {
  const DevConsoleScreen({super.key});

  @override
  State<DevConsoleScreen> createState() => _DevConsoleScreenState();
}

class _DevConsoleScreenState extends State<DevConsoleScreen> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Console'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tabButton(0, 'Logs'),
              _tabButton(1, 'Metrics'),
              _tabButton(2, 'Actions'),
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _tabButton(int index, String label) {
    final active = _activeTab == index;
    return TextButton(
      onPressed: () => setState(() => _activeTab = index),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Theme.of(context).colorScheme.primary : Colors.grey,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_activeTab == 0) {
      final logs = CrashReporter.logs;
      if (logs.isEmpty) {
        return const Center(child: Text('No telemetry logs captured.'));
      }
      return ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              logs[index],
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          );
        },
      );
    } else if (_activeTab == 1) {
      final metrics = PerformanceMonitor.metrics;
      if (metrics.isEmpty) {
        return const Center(child: Text('No performance metrics captured.'));
      }
      return ListView.builder(
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.speed_rounded),
            title: Text(
              metrics[index],
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
            ),
          );
        },
      );
    } else {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton.icon(
            onPressed: () {
              CrashReporter.logInfo('Simulating Developer Diagnostic Check...');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logs updated! Check Logs tab.')),
              );
            },
            icon: const Icon(Icons.bug_report_rounded),
            label: const Text('Simulate Diagnostic Event'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              CrashReporter.clear();
              PerformanceMonitor.clear();
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cleared logs & metrics.')),
              );
            },
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Clear All Diagnostics Data'),
          ),
        ],
      );
    }
  }
}
