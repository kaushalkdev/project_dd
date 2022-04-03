import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';
import 'package:project_dd/src/features/form/ui/goverment_schemes_section.dart';

class Modernization extends StatefulWidget {
  final People people;
  const Modernization({Key? key, required this.people}) : super(key: key);

  @override
  State<Modernization> createState() => _ModernizationState();
}

class _ModernizationState extends State<Modernization> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.people.modernization.isEmpty) {
      widget.people.modernization =
          await JsonLoader.loadJsonFromPath(Constants.modernizationQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Modernization Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.modernization,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(context, () => widget.people.save(),
              GovermentSchemes(people: widget.people)),
        ],
      ),
    );
  }
}
