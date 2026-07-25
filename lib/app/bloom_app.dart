import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/navigation/bloom_shell.dart';
import 'package:bloom/app/theme/bloom_theme.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';

class BloomApp extends StatelessWidget {
  const BloomApp({required this.services, super.key});

  final BloomServices services;

  @override
  Widget build(BuildContext context) {
    return BloomScope(
      services: services,
      child: MaterialApp(
        title: 'Bloom',
        debugShowCheckedModeBanner: false,
        theme: buildBloomTheme(),
        home: const BloomShell(),
      ),
    );
  }
}
