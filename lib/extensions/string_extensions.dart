import 'package:event_bus/event_bus.dart';

import '../services/service_config.dart';
import '../events/log_event.dart';

extension StringExtensions on String {
  void logInfo({
    Map<String, dynamic> metadata = const <String, dynamic>{},
  }) =>
      _log(LogEvent(message: this, level: LogLevel.info, metadata: metadata));

  void logError({
    Map<String, dynamic> metadata = const <String, dynamic>{},
  }) =>
      _log(LogEvent(message: this, level: LogLevel.error, metadata: metadata));

  void logDebug({
    Map<String, dynamic> metadata = const <String, dynamic>{},
  }) =>
      _log(LogEvent(message: this, level: LogLevel.debug, metadata: metadata));

  void _log(LogEvent event) => ServiceConfigMixin.locator.get<EventBus>().fire(event);
}
