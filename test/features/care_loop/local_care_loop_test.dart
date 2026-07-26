import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Phase 6 exit gate: search → add → plan → Today action → history, no network.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('clean-slate local care loop without sample seed', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final services = await BloomServices.bootstrapForTest(
      preferences: await SharedPreferences.getInstance(),
      seedSampleData: false,
    );

    await tester.pumpWidget(BloomApp(services: services, showSplash: false));
    await tester.pumpAndSettle();

    expect(find.textContaining('Add a houseplant'), findsOneWidget);
    expect(find.text('Nothing due yet'), findsOneWidget);
    expect(find.text('All done for today!'), findsNothing);

    await tester.tap(find.text('Go to Discover'));
    await tester.pumpAndSettle();
    expect(find.text('Popular houseplants'), findsOneWidget);

    await tester.enterText(find.byType(SearchBar), 'zz');
    await tester.pumpAndSettle();
    expect(find.text('ZZ Plant'), findsOneWidget);

    await tester.tap(find.text('ZZ Plant').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Your conditions'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Desk ZZ');
    await tester.pump();
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Add to My Plants'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Add to My Plants'));
    await tester.pumpAndSettle();

    expect(find.text('Get care reminders?'), findsOneWidget);
    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Today').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Desk ZZ'), findsWidgets);
    expect(find.textContaining('needs care today'), findsOneWidget);

    final doneToggle = find.byType(Checkbox).first;
    await tester.tap(doneToggle);
    await tester.pumpAndSettle();

    expect(find.text('All done for today!'), findsOneWidget);

    await tester.tap(find.text('My Plants').last);
    await tester.pumpAndSettle();
    expect(find.text('Desk ZZ'), findsOneWidget);

    await tester.tap(find.text('Desk ZZ').hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Care').hitTestable());
    await tester.pumpAndSettle();
    expect(find.textContaining('done'), findsWidgets);

    final plants = await services.care.listUserPlants();
    expect(plants, hasLength(1));
    expect(plants.first.displayName, 'Desk ZZ');
    final events = await services.care.listCareEvents(plants.first.id);
    expect(
      events.any((event) => event.label.toLowerCase().contains('done')),
      isTrue,
    );
  });
}
