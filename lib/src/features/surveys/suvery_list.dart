import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project_dd/src/core/adapters/people_adapter.dart';
import 'package:project_dd/src/core/services/constants.dart';
import 'package:project_dd/src/core/services/firebase_service.dart';
import 'package:project_dd/src/core/services/locator.dart';
import 'package:project_dd/src/features/form/ui/general_section.dart';
import 'package:uuid/uuid.dart';

class SurveyLists extends StatefulWidget {
  const SurveyLists({Key? key}) : super(key: key);

  @override
  State<SurveyLists> createState() => _SurveyListsState();
}

class _SurveyListsState extends State<SurveyLists> {
  bool isUploading = false;
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
        actions: [
          GestureDetector(
            child: const Icon(Icons.import_export),
            onTap: () async {
              isUploading = true;
              setState(() {});
              await Future.delayed(const Duration(seconds: 1));
              Hive.box<People>(Constants.hiveBox).values.toList();
              Hive.box<People>(Constants.hiveBox).values.forEach((people) {
                // uploading data to firebase
                getIt
                    .get<FirebaseService>()
                    .addPeople(people)
                    .onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
                // create a json file
                // read the records people by people
                // add the entries in the json file
                // save it to phone_location or mail or whatever.
              });
              isUploading = false;
              setState(() {});
            },
          )
        ],
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<Box<People>>(
            valueListenable: Hive.box<People>(Constants.hiveBox).listenable(),
            builder: (context, value, _) {
              return value.isEmpty
                  ? const Center(
                      child: Text('No surveys yet'),
                    )
                  : buildSurverys(value);
            },
          ),
          if (isUploading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
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
    String groupValue = '';
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: groupValue,
                              onChanged: (changed) {
                                setState(
                                  () {
                                    groupValue = changed!;
                                    people.gender = groupValue;
                                  },
                                );
                              },
                            ),
                            const Text('Male')
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Female',
                              groupValue: groupValue,
                              onChanged: (changed) {
                                groupValue = changed!;
                                people.gender = groupValue;
                                setState(() {});
                              },
                            ),
                            const Text('Female')
                          ],
                        )
                      ],
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
              ),
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
            Spacer(),
            Text(people.gender.toUpperCase()),
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
                  getIt
                      .get<FirebaseService>()
                      .deletePerson(value.getAt(index)!)
                      .then((_) {
                    value.deleteAt(index);
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
