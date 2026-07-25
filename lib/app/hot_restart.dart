import 'dart:ui';

import 'package:bloom/data/reminders/reminder_action_bridge.dart';
import 'package:flutter/foundation.dart';

/// Clears [IsolateNameServer] leftovers that Flutter hot restart does not.
void clearHotRestartPorts() {
  if (!kDebugMode) {
    return;
  }
  IsolateNameServer.removePortNameMapping(ReminderActionBridge.portName);
  // Legacy ports if an older build used drift_flutter shareAcrossIsolates.
  IsolateNameServer.removePortNameMapping('drift-db/bloom');
  IsolateNameServer.removePortNameMapping('drift-db/bloom/control');
}
