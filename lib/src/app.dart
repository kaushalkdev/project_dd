import 'package:flutter/material.dart';
import 'package:project_dd/src/features/surveys/suvery_list.dart';

class AppDD extends StatelessWidget {
  const AppDD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SurveyLists(),
    );
  }
}
