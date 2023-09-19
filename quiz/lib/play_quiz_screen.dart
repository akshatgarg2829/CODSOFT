import 'package:flutter/material.dart';

import 'Question.dart';

class PlayQuizScreen extends StatefulWidget {
  final List<Question> quizQuestions;

  PlayQuizScreen(this.quizQuestions);

  @override
  _PlayQuizScreenState createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  bool _isQuizFinished = false;

  void _checkAnswer(int selectedOptionIndex) {
    if (!_isQuizFinished) {
      if (selectedOptionIndex == widget.quizQuestions[_questionIndex].correctOptionIndex) {
        setState(() {
          _score++;
        });
      }
      _nextQuestion();
    }
  }

  void _nextQuestion() {
    if (_questionIndex < widget.quizQuestions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      setState(() {
        _isQuizFinished = true;
      });
    }
  }

  void _retryQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _isQuizFinished = false;
    });
  }

  void _goToHome() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    if (_isQuizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Result'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Quiz Finished!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Your Score: $_score / ${widget.quizQuestions.length}',
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: _retryQuiz,
                child: Text('Retry Quiz'),
              ),
              ElevatedButton(
                onPressed: _goToHome,
                child: Text('Go to Home'),
              ),
            ],
          ),
        ),
      );
    }

    final question = widget.quizQuestions[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Question ${_questionIndex + 1}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              question.questionText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                for (int i = 0; i < question.options.length; i++)
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer(i);
                    },
                    child: Text(question.options[i]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
