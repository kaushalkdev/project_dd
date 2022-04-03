import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget save(
      BuildContext context, Future<void> Function() save, Widget child,
      [bool navigateHome = false]) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          await save();
          if (navigateHome) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => child));
          }
        },
        child: const Text('Save'),
      ),
    );
  }

  static Widget questionBuilder(
      {required Map<String, dynamic> questions,
      required void Function() updateState}) {
    return Expanded(
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, questionIndex) {
          if (questions.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }

          return _singleQuestion(questionIndex, questions, updateState);
        },
      ),
    );
  }

  static ListTile _singleQuestion(int questionIndex,
      Map<String, dynamic> questions, void Function() updateState) {
    return ListTile(
        title: Text(questions['q$questionIndex']['name']),
        subtitle: Column(
          children: [
            for (int optionIndex = 0;
                optionIndex < questions['q$questionIndex']['options'].length;
                optionIndex++)
              _singleOption(questionIndex, optionIndex, questions, updateState),
          ],
        ));
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
        Text(questions['q$questionIndex']['options'][optionIndex]['val']),
      ],
    );
  }
}
