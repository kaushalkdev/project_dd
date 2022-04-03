import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';

import 'economy_section.dart';

class HealthProfile extends StatefulWidget {
  final People people;
  const HealthProfile({Key? key, required this.people}) : super(key: key);

  @override
  State<HealthProfile> createState() => _HealthProfileState();
}

class _HealthProfileState extends State<HealthProfile> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.people.health.isEmpty) {
      widget.people.health =
          await JsonLoader.loadJsonFromPath(Constants.healthQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Health Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.health,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(context, () => widget.people.save(),
              Economy(people: widget.people)),
        ],
      ),
    );
  }
}
