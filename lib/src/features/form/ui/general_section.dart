import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';
import 'package:project_dd/src/features/form/ui/social_relogious_section.dart';

class GeneralSection extends StatefulWidget {
  final People people;
  const GeneralSection({Key? key, required this.people}) : super(key: key);

  @override
  State<GeneralSection> createState() => _GeneralSectionState();
}

class _GeneralSectionState extends State<GeneralSection> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.people.general.isEmpty) {
      widget.people.general =
          await JsonLoader.loadJsonFromPath(Constants.generalQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('General Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.general,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(context, () => widget.people.save(),
              SocialReligious(people: widget.people)),
        ],
      ),
    );
  }
}
