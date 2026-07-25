import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/navigation/bloom_shell.dart';
import 'package:bloom/app/presentation/bloom_splash_screen.dart';
import 'package:bloom/app/theme/bloom_scroll_behavior.dart';
import 'package:bloom/app/theme/bloom_theme.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/reminders/reminder_action_bridge.dart';
import 'package:flutter/material.dart';

class BloomApp extends StatefulWidget {
  const BloomApp({required this.services, this.showSplash = true, super.key});

  final BloomServices services;

  /// When false, opens straight into the shell (used by widget tests).
  final bool showSplash;

  @override
  State<BloomApp> createState() => _BloomAppState();
}

class _BloomAppState extends State<BloomApp> with WidgetsBindingObserver {
  late var _showSplash = widget.showSplash;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ReminderActionBridge.listen(widget.services.notifyDataChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.services.reminders.reconcile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BloomScope(
      services: widget.services,
      child: MaterialApp(
        title: 'Bloom',
        debugShowCheckedModeBanner: false,
        theme: buildBloomTheme(),
        scrollBehavior: const BloomScrollBehavior(),
        home: _showSplash
            ? BloomSplashScreen(
                onFinished: () {
                  if (!mounted) {
                    return;
                  }
                  setState(() => _showSplash = false);
                },
              )
            : const BloomShell(),
      ),
    );
  }
}
