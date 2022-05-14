import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget save(
      BuildContext context, Future<void> Function() save, Widget child,
      [bool navigateHome = false]) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          save().then((_) {
            if (navigateHome) {
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => child));
            }
          });
        },
        child: const Text('Save'),
      ),
    );
  }

  static Widget questionBuilder(
      {required Map<String, dynamic> questions,
      required void Function() updateState,
      required String gender}) {
    return Expanded(
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, questionIndex) {
          if (questions.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }

          return singleQuestion(questionIndex, questions, updateState, gender);
        },
      ),
    );
  }

  static Widget singleQuestion(
      int questionIndex,
      Map<String, dynamic> questions,
      void Function() updateState,
      String gender) {
    Map<dynamic, dynamic> qmap = questions['q$questionIndex'];
    if (qmap['isFemaleOnly'] && gender.toLowerCase() == 'male') {
      return Container();
    } else {
      return buildQuestion(qmap, questionIndex, questions, updateState);
    }
  }

  static Row _singleOption(int questionIndex, int optionIndex,
      Map<String, dynamic> questions, void Function() updateState) {
    return Row(
      children: [
        Checkbox(
          value: questions['q$questionIndex']['options'][optionIndex]
              ['checked'],
          onChanged: (value) {
            questions['q$questionIndex']['options'][optionIndex]['checked'] =
                value;
            updateState();
          },
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            questions['q$questionIndex']['options'][optionIndex]['val'],
          ),
        )),
      ],
    );
  }

  static Widget buildQuestion(Map qmap, int questionIndex,
      Map<String, dynamic> questions, void Function() updateState) {
    // if the question does not have options then render textfield.
    if (qmap['options'].length == 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 7,
          child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(qmap['name'], textAlign: TextAlign.start),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: qmap['openEndedAnswer'],
                  decoration: const InputDecoration(hintText: 'Type here...'),
                  onChanged: (changedAnswer) {
                    qmap['openEndedAnswer'] = changedAnswer;
                  },
                ),
              )),
        ),
      );
    }
    // else return question with option.
    else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 7,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(qmap['name']),
            ),
            subtitle: Column(
              children: [
                for (int optionIndex = 0;
                    optionIndex < qmap['options'].length;
                    optionIndex++)
                  _singleOption(
                      questionIndex, optionIndex, questions, updateState),
              ],
            ),
          ),
        ),
      );
    }
  }
}
