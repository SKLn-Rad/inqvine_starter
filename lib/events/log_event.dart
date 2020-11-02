import 'package:flutter/material.dart';

class LogEvent {
  LogEvent({
    @required this.message,
    this.level = LogLevel.info,
    this.metadata = const <String, dynamic>{},
  });

  final LogLevel level;
  final String message;
  final Map<String, dynamic> metadata;
}

enum LogLevel { info, debug, error }
