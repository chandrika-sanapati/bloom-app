import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/navigation/bloom_shell.dart';
import 'package:bloom/app/theme/bloom_theme.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';

class BloomApp extends StatefulWidget {
  const BloomApp({required this.services, super.key});

  final BloomServices services;

  @override
  State<BloomApp> createState() => _BloomAppState();
}

class _BloomAppState extends State<BloomApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
        home: const BloomShell(),
      ),
    );
  }
}
