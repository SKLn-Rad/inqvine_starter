import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../extensions/string_extensions.dart';
import 'service_config.dart';

class AuthService extends ChangeNotifier with ServiceConfigMixin {
  User _currentUser;
  User get currentUser => _currentUser;

  bool get isLoggedIn => currentUser != null;

  StreamSubscription<User> userSubscription;

  Future<void> initializeService() async {
    'Checking is a user is already logged in'.logInfo();
    userSubscription = firebaseAuth.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> logout() async {
    if (currentUser == null) {
      'Cannot logout of an already signed out account'.logError();
      return;
    }

    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> loginWithGoogle() async {
    if (currentUser != null) {
      'Cannot login when already logged in'.logError();
      return;
    }

    'Signing in with Google'.logInfo();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      //* Sign in canceled
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    'Signing in with Firebase'.logInfo();
    await firebaseAuth.signInWithCredential(authCredential);
    'Sign in was successful'.logInfo();
  }

  void onAuthStateChanged(User user) {
    'Detected a change to authentication state'.logInfo();
    _currentUser = user;
  }

  @override
  void dispose() {
    userSubscription?.cancel();
    super.dispose();
  }
}
