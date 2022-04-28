import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';
import 'package:project_dd/src/features/form/ui/education_section.dart';

class GovermentSchemes extends StatefulWidget {
  final People people;
  const GovermentSchemes({Key? key, required this.people}) : super(key: key);

  @override
  State<GovermentSchemes> createState() => _GovermentSchemesState();
}

class _GovermentSchemesState extends State<GovermentSchemes> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.people.governmentSchemes.isEmpty) {
      widget.people.governmentSchemes =
          await JsonLoader.loadJsonFromPath(Constants.governmentSchemesQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Goverment Schemes Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.governmentSchemes,
              gender: widget.people.gender,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(
            context,
            () => widget.people.save(),
            Education(people: widget.people),
          ),
        ],
      ),
    );
  }
}
