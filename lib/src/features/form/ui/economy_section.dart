import 'package:flutter/material.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/widgets/common_widgets.dart';
import 'package:project_dd/src/features/form/apis/load_json_data.dart';
import 'package:project_dd/src/features/form/ui/impact_of_modernization_section.dart';

class Economy extends StatefulWidget {
  final People people;
  const Economy({Key? key, required this.people}) : super(key: key);

  @override
  State<Economy> createState() => _EconomyState();
}

class _EconomyState extends State<Economy> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (widget.people.economy.isEmpty) {
      widget.people.economy =
          await JsonLoader.loadJsonFromPath(Constants.economyQues);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Economy Section'),
      ),
      body: Column(
        children: [
          CommonWidgets.questionBuilder(
              questions: widget.people.economy,
              updateState: () {
                setState(() {});
              }),
          CommonWidgets.save(context, () => widget.people.save(),
              Modernization(people: widget.people)),
        ],
      ),
    );
  }
}
