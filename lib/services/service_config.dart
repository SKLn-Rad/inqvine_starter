import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../extensions/string_extensions.dart';

import 'application_service.dart';
import 'auth_service.dart';
import 'logger_service.dart';

Future<void> initializeServices(ApplicationVersion version) async {
  ServiceConfigMixin.locator.registerSingleton(version);
  ServiceConfigMixin.locator.registerSingleton(Logger());
  ServiceConfigMixin.locator.registerSingleton(EventBus());

  /// Setup `Firebase Dependencies`
  await Firebase.initializeApp();

  //* Disabled crashlytics during debugging of the application
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  ServiceConfigMixin.locator.registerSingleton(FirebaseCrashlytics.instance);
  ServiceConfigMixin.locator.registerSingleton(FirebaseFirestore.instance);
  ServiceConfigMixin.locator.registerSingleton(FirebaseAuth.instance);
  ServiceConfigMixin.locator.registerSingleton(GoogleSignIn());

  /// Load in service layer
  ServiceConfigMixin.locator.registerSingleton(LoggerService()..initializeService());

  final AuthService authService = AuthService();
  await authService.initializeService();
  ServiceConfigMixin.locator.registerSingleton(authService);

  if (authService.firebaseAuth.currentUser == null) {
    'Not currently signed in'.logInfo();
  } else {
    'Signed in as: ${authService.firebaseAuth.currentUser}'.logInfo();
  }
}

abstract class ServiceConfigMixin {
  /// Contains all registered services
  static GetIt get locator => GetIt.instance;

  Logger get logger => locator.get();
  EventBus get eventBus => locator.get();
  ApplicationVersion get applicationVersion => locator.get();

  LoggerService get loggerService => locator.get();
  AuthService get authService => locator.get();

  FirebaseCrashlytics get firebaseCrashlytics => locator.get();
  FirebaseFirestore get firebaseFirestore => locator.get();
  FirebaseAuth get firebaseAuth => locator.get();
  GoogleSignIn get googleSignIn => locator.get();
}
