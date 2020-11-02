import 'package:flutter/material.dart';

class ApplicationConstants {
  static const String applicationName = '';
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (_) => Scaffold(),
  };
}
