import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import 'lifecycle_hook.dart';

T useViewModel<T extends BaseViewModel>(T Function() buildModel) {
  final bool hasOverridenViewModel = GetIt.instance.isRegistered<T>();
  T model;

  if (hasOverridenViewModel) {
    model = GetIt.instance.get<T>();
  } else {
    model = buildModel();
    GetIt.instance.registerSingleton(model);
  }

  useLifecycleHook(model);
  useProvider(ChangeNotifierProvider((_) => model));

  return model;
}

abstract class BaseViewModel extends ChangeNotifier with LifecycleMixin {
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }
}
