import 'package:bloom/app/navigation/bloom_shell.dart';
import 'package:bloom/app/theme/bloom_theme.dart';
import 'package:flutter/material.dart';

class BloomApp extends StatelessWidget {
  const BloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloom',
      debugShowCheckedModeBanner: false,
      theme: buildBloomTheme(),
      home: const BloomShell(),
    );
  }
}
