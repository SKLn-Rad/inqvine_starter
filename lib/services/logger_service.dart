import 'dart:async';

import 'package:flutter/material.dart';

import '../events/log_event.dart';
import 'application_service.dart';
import 'service_config.dart';

class LoggerService extends ChangeNotifier with ServiceConfigMixin {
  StreamSubscription<LogEvent> logSubscription;

  void initializeService() {
    logSubscription = eventBus.on<LogEvent>().listen(onLogFired);
  }

  void onLogFired(LogEvent event) {
    if (applicationVersion == ApplicationVersion.production && event.level == LogLevel.debug) {
      return;
    }

    switch (event.level) {
      case LogLevel.info:
        logger.i(event.message);
        break;
      case LogLevel.debug:
        logger.d(event.message);
        break;
      case LogLevel.error:
        logger.e(event.message);
        break;
    }
  }

  @override
  void dispose() {
    logSubscription?.cancel();
    super.dispose();
  }
}
