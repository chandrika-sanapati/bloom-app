import 'package:bloom/app/theme/bloom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses bouncing physics on Android', (tester) async {
    late ScrollPhysics physics;

    await tester.pumpWidget(
      MaterialApp(
        scrollBehavior: const BloomScrollBehavior(),
        home: Builder(
          builder: (context) {
            physics = ScrollConfiguration.of(context).getScrollPhysics(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(physics, isA<BouncingScrollPhysics>());
  });
}
