import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('cold-start launch action completes the task once', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final scheduler = RecordingReminderScheduler()
      ..launchAction = (
        taskId: 'task-snake-water',
        action: ReminderAction.done,
      );

    final services = await BloomServices.bootstrapForTest(
      database: BloomDatabase.memory(),
      preferences: prefs,
      scheduler: scheduler,
    );

    final task = await services.care.getCareTask('task-snake-water');
    expect(task?.isDone, isTrue);
    expect(scheduler.scheduled.containsKey('task-snake-water'), isFalse);
    expect(scheduler.launchAction, isNull);

    final events = await services.care.listCareEvents('plant-snake');
    expect(events.where((event) => event.label.contains('done')).length, 1);
  });
}
