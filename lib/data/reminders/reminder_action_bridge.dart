import 'dart:isolate';
import 'dart:ui';

/// Cross-engine bridge so background notification actions can refresh the UI.
abstract final class ReminderActionBridge {
  static const portName = 'bloom.reminder.data_changed';

  /// Register on the UI isolate; [onChanged] bumps Today / My Plants.
  static void listen(void Function() onChanged) {
    final port = ReceivePort();
    IsolateNameServer.removePortNameMapping(portName);
    IsolateNameServer.registerPortWithName(port.sendPort, portName);
    port.listen((_) => onChanged());
  }

  static void notifyUiChanged() {
    IsolateNameServer.lookupPortByName(portName)?.send(null);
  }
}
