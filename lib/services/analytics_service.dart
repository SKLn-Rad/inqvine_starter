import 'dart:async';

import 'package:flutter/material.dart';

import '../extensions/string_extensions.dart';
import '../events/log_event.dart';
import 'service_config.dart';

class AnalyticsService extends ChangeNotifier with ServiceConfigMixin {
  StreamSubscription<LogEvent> logSubscription;

  void initializeService() {
    logSubscription = eventBus.on<LogEvent>().listen(onLogFired);
  }

  Future<void> onLogFired(LogEvent event) async {
    if (event.level != LogLevel.error) {
      return;
    }

    'Sending error to Crashlytics'.logInfo();
    await firebaseCrashlytics.log(event.message);
  }

  @override
  void dispose() {
    logSubscription?.cancel();
    super.dispose();
  }
}
