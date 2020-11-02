import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GetIt get locator => GetIt.instance;

T useService<T extends ChangeNotifier>() {
  T model = GetIt.instance.get<T>();
  useProvider(ChangeNotifierProvider((_) => model));
  return model;
}

Future<void> setupServices() async {}
