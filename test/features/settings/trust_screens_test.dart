import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/shared/legal/bloom_legal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Settings opens privacy and about trust screens', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final services = await BloomServices.bootstrapForTest(
      preferences: await SharedPreferences.getInstance(),
    );

    await tester.pumpWidget(BloomApp(services: services, showSplash: false));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Care reminders'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Privacy'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Privacy').hitTestable());
    await tester.pumpAndSettle();
    expect(find.textContaining('local-first'), findsWidgets);
    expect(find.textContaining('Delete all local data'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('About Bloom'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('About Bloom').hitTestable());
    await tester.pumpAndSettle();

    expect(find.text(BloomLegal.versionLabel), findsOneWidget);
    expect(find.textContaining(BloomLegal.supportEmail), findsOneWidget);

    await tester.tap(find.text('Attribution'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Plant placeholder image attribution'),
      findsWidgets,
    );
  });
}
