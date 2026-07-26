import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Today skip removes open task via overflow menu', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final services = await BloomServices.bootstrapForTest(
      preferences: await SharedPreferences.getInstance(),
    );

    await tester.pumpWidget(BloomApp(services: services, showSplash: false));
    await tester.pumpAndSettle();

    expect(find.text('Snake Plant'), findsWidgets);

    await tester.tap(find.byTooltip('Task actions').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip').last);
    await tester.pumpAndSettle();

    expect(find.text('Skipped'), findsOneWidget);

    final snakeOpen = await services.care.getCareTask('task-snake-water');
    expect(snakeOpen?.isDone, isTrue);
  });
}
