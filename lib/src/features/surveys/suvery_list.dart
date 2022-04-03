import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/features/form/ui/general_section.dart';
import 'package:uuid/uuid.dart';

class SurveyLists extends StatefulWidget {
  const SurveyLists({Key? key}) : super(key: key);

  @override
  State<SurveyLists> createState() => _SurveyListsState();
}

class _SurveyListsState extends State<SurveyLists> {
  @override
  void dispose() {
    super.dispose();
    Hive.box(Constants.hiveBox).close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Surveys'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<People>>(
        valueListenable: Hive.box<People>(Constants.hiveBox).listenable(),
        builder: (context, value, _) {
          return value.isEmpty
              ? const Center(
                  child: Text('No surveys yet'),
                )
              : buildSurverys(value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final people = People()
            ..uuid = const Uuid().v4()
            ..dateTime = DateTime.now();
          addPerson(context, people);
        },
      ),
    );
  }

  ListView buildSurverys(Box<People> value) {
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context, index) {
        final people = value.getAt(index);
        return Dismissible(
          key: Key(people!.uuid),
          confirmDismiss: (direction) async {
            deleteDialog(context, value, index);
            return false;
          },
          child: singlePerson(people, context),
        );
      },
    );
  }

  Future<dynamic> addPerson(BuildContext context, People people) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add a person'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      people.name = value;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                    ),
                    onChanged: (value) {
                      people.location = value;
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Hive.box<People>(Constants.hiveBox).add(people);
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  Card singlePerson(People people, BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.blue,
            ),
            Text(people.name.toUpperCase()),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                Text(people.location),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.alarm,
                  color: Colors.blue,
                ),
                Text(DateFormat('dd-MMM-yy').format(people.dateTime)),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => GeneralSection(
                  people: people,
                ),
              ));
        },
      ),
    );
  }

  Future<dynamic> deleteDialog(
      BuildContext context, Box<People> value, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete this survey?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: const ButtonStyle(),
                child: const Text('Delete'),
                onPressed: () {
                  value.deleteAt(index);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
