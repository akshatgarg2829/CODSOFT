import 'package:flutter/material.dart';
import 'Question.dart';
import 'create_quiz_screen.dart';
import 'play_quiz_screen.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/createQuiz': (context) => CreateQuizScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final quizQuestions = await Navigator.pushNamed(context, '/createQuiz');
                if (quizQuestions != null && quizQuestions is List<Question>) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayQuizScreen(quizQuestions),
                    ),
                  );
                }
              },
              child: Text('Create Quiz'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to fetch quizzes or load quizzes from a source.
                // For now, we'll just navigate to the PlayQuizScreen with a sample quiz.
                final sampleQuiz = [
                  Question(
                    'What is the capital of France?',
                    ['Paris', 'London', 'Berlin', 'Madrid'],
                    0,
                  ),
                  Question(
                    'What is 2 + 2?',
                    ['3', '4', '5', '6'],
                    1,
                  ),
                  // Add more questions here.
                ];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayQuizScreen(sampleQuiz),
                  ),
                );
              },
              child: Text('Play Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
