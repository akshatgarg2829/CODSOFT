
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// // make a stateless widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Calculator',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const FirstPage(title: 'Calculator'),
//     );
//   }
// }

// class FirstPage extends StatefulWidget {
//   const FirstPage({super.key, required this.title});

//   final String title;

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   String output = "0";
//   String _output = "0";
//   double num1 = 0;
//   double num2 = 0;
//   String operand = "";

//   buttonPressed(String buttonText) {
//     if(buttonText == "CLR"){
//       _output = "0";
//       num1 = 0;
//       num2 = 0;
//       operand = "";

//     }
    
//     else if(buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/" || buttonText == "%"){
//       num1 = double.parse(output);
//       operand = buttonText;
//       _output = "0";
//     }
//     else if(buttonText == "."){
//       if(_output.contains(".")){
//         print("Already contains a decimal");
//       }
//       else{
//         _output = _output + buttonText;
//       }
//     }
//     else if(buttonText == "="){
//       num2 = double.parse(output);
//       if(operand == "+"){
//         _output = (num1 + num2).toString();
//       }
//       if(operand == "-"){
//         _output = (num1 - num2).toString();
//       }
//       if(operand == "X"){
//         _output = (num1 * num2).toString();
//       }
//       if(operand == "/"){
//         _output = (num1 / num2).toString();
//       }
//       if(operand == "%"){
//         _output = ((num1 / num2) * 100).toString();
//       }
//       num1 = 0;
//       num2 = 0;
//       operand = "";

//     }
//     else{
//       _output = _output + buttonText;
//     }
//     // ignore: avoid_print
//     print(_output);
//     setState(() {
//       output = newMethod.toStringAsFixed(0);
//     });
//   }

//   double get newMethod => double.parse(_output);

//   Widget buildButton(String buttonText) {
//     return Expanded(
//       child: SizedBox(
//         height: 90.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 4.0),
//           child: OutlinedButton(
//             child: Text(
//               buttonText,
//               style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
//             ),
//             onPressed: () => buttonPressed(buttonText),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.centerRight,
//               padding: EdgeInsets.symmetric(vertical: 36.0, horizontal: 20.0),
//               child: Text(
//                 output,
//                 style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Expanded(
//               child: Divider(
//                 indent: 500.0,
//               ),
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     buildButton("CLR"),
//                     buildButton("%"),
//                     buildButton("X"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     buildButton("7"),
//                     buildButton("8"),
//                     buildButton("9"),
//                     buildButton("/"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     buildButton("4"),
//                     buildButton("5"),
//                     buildButton("6"),
//                     buildButton("+"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     buildButton("1"),
//                     buildButton("2"),
//                     buildButton("3"),
//                     buildButton("-"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     buildButton("0"),
//                     buildButton("00"),
//                     buildButton("."),
//                     buildButton("="),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _currentInput = '';
  String _prevInput = '';
  String _operation = '';

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      _setOperation(buttonText);
    } else if (buttonText == '=') {
      _calculateResult();
    } else {
      setState(() {
        _currentInput += buttonText;
        _output = _currentInput;
      });
    }
  }

  void _clear() {
    setState(() {
      _currentInput = '';
      _prevInput = '';
      _operation = '';
      _output = '';
    });
  }

  void _setOperation(String operation) {
    setState(() {
      _operation = operation;
      _prevInput = _currentInput;
      _currentInput = '';
    });
  }

  void _calculateResult() {
    double result = 0;
    double num1 = double.parse(_prevInput);
    double num2 = double.parse(_currentInput);

    switch (_operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          _output = 'Error';
          return;
        }
        break;
    }

    setState(() {
      _output = result.toString();
      _prevInput = '';
      _currentInput = result.toString();
      _operation = '';
    });
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
              child: Text(
                _output,
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('x'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

}
