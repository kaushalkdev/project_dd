import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:project_dd/src/app.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PeopleAdapter());
  await Hive.openBox<People>(Constants.hiveBox);
  registerLocators();
  runApp(const AppDD());
}
