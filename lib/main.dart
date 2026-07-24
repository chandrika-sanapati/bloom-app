import 'package:flutter/material.dart';

void main() {
  runApp(const BloomApp());
}

class BloomApp extends StatelessWidget {
  const BloomApp({super.key});

  static const _seedColor = Color(0xFF2AAA8A);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
      ),
      home: const BloomHomeScreen(),
    );
  }
}

class BloomHomeScreen extends StatelessWidget {
  const BloomHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloom')),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.eco_outlined, size: 48),
                SizedBox(height: 16),
                Text('Your plant-care companion', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
