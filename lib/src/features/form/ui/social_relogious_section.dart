import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';
import 'package:project_dd/src/features/form/ui/health_profile.dart';

class SocialReligious extends StatefulWidget {
  final People people;
  const SocialReligious({Key? key, required this.people}) : super(key: key);

  @override
  State<SocialReligious> createState() => _SocialReligiousState();
}

class _SocialReligiousState extends State<SocialReligious> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.people.social.isEmpty) {
      widget.people.social =
          await JsonLoader.loadJsonFromPath(Constants.socialQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Social and Religious Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.social,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(context, () => widget.people.save(),
              HealthProfile(people: widget.people)),
        ],
      ),
    );
  }
}
