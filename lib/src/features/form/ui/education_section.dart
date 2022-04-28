import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';

import '../../../core/services/constants.dart';
import '../../../core/widgets/common_widgets.dart';
import '../apis/load_json_data.dart';

class Education extends StatefulWidget {
  final People people;
  const Education({Key? key, required this.people}) : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.people.education.isEmpty) {
      widget.people.education =
          await JsonLoader.loadJsonFromPath(Constants.educationQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Education Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.education,
              gender: widget.people.gender,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(
              context, () => widget.people.save(), Container(), true),
        ],
      ),
    );
  }
}
