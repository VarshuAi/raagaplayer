import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'crash_reporter.dart';

class DevConsoleOverlay extends StatefulWidget {
  final Widget child;
  const DevConsoleOverlay({super.key, required this.child});

  @override
  State<DevConsoleOverlay> createState() => _DevConsoleOverlayState();
}

class _DevConsoleOverlayState extends State<DevConsoleOverlay> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Floating Dev Console Toggle Button
        Positioned(
          bottom: 110,
          right: 16,
          child: Material(
            elevation: 8,
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () => setState(() => _isOpen = !_isOpen),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF89B4FA), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  _isOpen ? Icons.close_rounded : Icons.terminal_rounded,
                  color: const Color(0xFF89B4FA),
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        // Live Developer Logs Bottom Sheet Drawer
        if (_isOpen)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Material(
              color: const Color(0xFF11111B),
              elevation: 16,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Console Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF181825),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.terminal_rounded, color: Color(0xFFA6E3A1), size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Dev Log Console',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy_rounded, color: Color(0xFF89B4FA), size: 20),
                          tooltip: 'Copy Logs',
                          onPressed: () {
                            final text = CrashReporter.logs.join('\n');
                            Clipboard.setData(ClipboardData(text: text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('📋 All Dev Logs Copied to Clipboard!'),
                                backgroundColor: Color(0xFFA6E3A1),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFF38BA8), size: 20),
                          tooltip: 'Clear Logs',
                          onPressed: () {
                            setState(() {
                              CrashReporter.clear();
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
                          onPressed: () => setState(() => _isOpen = false),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  // Console Logs Output List
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: ValueNotifier(CrashReporter.logs),
                      builder: (context, logs, _) {
                        if (logs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No logs captured yet.\nPlay a song to view live activity!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white38, fontSize: 13),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: logs.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final log = logs[logs.length - 1 - index]; // Latest first
                            final isError = log.contains('ERROR') || log.contains('failed') || log.contains('Exception');
                            final isSuccess = log.contains('Successfully') || log.contains('playing') || log.contains('200');

                            Color accent = const Color(0xFFCDD6F4);
                            if (isError) accent = const Color(0xFFF38BA8);
                            if (isSuccess) accent = const Color(0xFFA6E3A1);

                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E2E),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: accent.withOpacity(0.3), width: 1),
                              ),
                              child: SelectableText(
                                log,
                                style: TextStyle(
                                  color: accent,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  height: 1.4,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
