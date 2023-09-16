import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Set the default theme to dark
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clearAll();
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'CE') {
        _clearEntry();
      } else if (buttonText == '%') {
        _addPercentage();
      } else if (buttonText == '(' || buttonText == ')') {
        _addBracket(buttonText);
      } else {
        // Handle both 'x' and '*' for multiplication
        if (buttonText == 'x') {
          buttonText = '*';
        }
        _input += buttonText;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _input = '';
      _output = '';
    });
  }

  void _clearEntry() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void _addPercentage() {
    setState(() {
      _input += '%';
    });
  }

  void _addBracket(String bracket) {
    setState(() {
      _input += bracket;
    });
  }

  void _calculateResult() {
    try {
      // Replace 'x' with '*'
      _input = _input.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      _output = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      _output = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _input,
                    style: TextStyle(fontSize: 32.0, color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('CE', Colors.black), // Open bracket
              _buildButton('(', Colors.black), // Close bracket
              _buildButton(')', Colors.black), // Percentage
              _buildButton('%', Colors.orange), // Clear entry
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7', Colors.black),
              _buildButton('8', Colors.black),
              _buildButton('9', Colors.black),
              _buildButton('/', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4', Colors.black),
              _buildButton('5', Colors.black),
              _buildButton('6', Colors.black),
              _buildButton('x', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1', Colors.black),
              _buildButton('2', Colors.black),
              _buildButton('3', Colors.black),
              _buildButton('-', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('C', Colors.red), // Clear all
              _buildButton('0', Colors.black),
              _buildButton('=', Colors.black),
              _buildButton('+', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText, Color color) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: color, // Custom button color
          elevation: 5, // Add elevation for a raised look
        ),
      ),
    );
  }
}
