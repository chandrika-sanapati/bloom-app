import 'package:bloom/app/presentation/bloom_splash_screen.dart';
import 'package:bloom/app/theme/bloom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('splash animates brand mark then finishes', (tester) async {
    var finished = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: buildBloomTheme(),
        home: BloomSplashScreen(
          duration: const Duration(milliseconds: 400),
          onFinished: () => finished = true,
        ),
      ),
    );

    expect(find.text('Bloom'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(finished, isFalse);

    await tester.pump(); // start post-frame forward()
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pumpAndSettle();

    expect(finished, isTrue);
  });
}
