import 'package:flutter/material.dart';

import 'app.dart';
import 'services/application_service.dart';
import 'services/service_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServices(ApplicationVersion.production);
  startApplication();
}
