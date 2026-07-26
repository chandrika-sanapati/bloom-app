import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('edits nickname and care plan from plant detail', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final services = await BloomServices.bootstrapForTest(
      preferences: await SharedPreferences.getInstance(),
    );

    await tester.pumpWidget(
      BloomApp(services: services, showSplash: false),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('My Plants').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Peace Lily').hitTestable());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Edit nickname'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Living Room Lily');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Living Room Lily'), findsWidgets);

    await tester.tap(find.text('About').hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(find.text('Edit care plan'), findsOneWidget);

    final cadenceField = find.byType(TextField).first;
    await tester.enterText(cadenceField, 'Water when leaves droop');
    await tester.pump();
    await tester.ensureVisible(find.text('Save care plan'));
    await tester.tap(find.text('Save care plan'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Water when leaves droop'), findsWidgets);

    final plant = await services.care.getUserPlant('plant-lily');
    expect(plant?.displayName, 'Living Room Lily');
    final plan = await services.care.getCarePlan('plant-lily');
    expect(plan.first.cadenceLabel, 'Water when leaves droop');
  });
}
