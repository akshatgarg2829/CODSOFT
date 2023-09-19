import 'package:flutter/material.dart';

import 'Question.dart';


class CreateQuizScreen extends StatefulWidget {
  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  int correctOptionIndex = 0; // Default to the first option as correct.

  List<Question> quizQuestions = [];

  void addQuestion() {
    final questionText = questionController.text;
    final options = [
      option1Controller.text,
      option2Controller.text,
      option3Controller.text,
      option4Controller.text,
    ];

    final question = Question(questionText, options, correctOptionIndex);

    setState(() {
      quizQuestions.add(question);

      // Clear text controllers and reset the correct option to the first one.
      questionController.clear();
      option1Controller.clear();
      option2Controller.clear();
      option3Controller.clear();
      option4Controller.clear();
      correctOptionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Enter Question'),
            ),
            SizedBox(height: 10),
            for (int i = 0; i < 4; i++)
              Row(
                children: <Widget>[
                  Radio<int>(
                    value: i,
                    groupValue: correctOptionIndex,
                    onChanged: (value) {
                      setState(() {
                        correctOptionIndex = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: i == 0
                          ? option1Controller
                          : i == 1
                              ? option2Controller
                              : i == 2
                                  ? option3Controller
                                  : option4Controller,
                      decoration: InputDecoration(
                          labelText: 'Enter Option ${i + 1}'),
                    ),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the created quiz and navigate back to the main screen.
                Navigator.pop(context, quizQuestions);
              },
              child: Text('Save Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
