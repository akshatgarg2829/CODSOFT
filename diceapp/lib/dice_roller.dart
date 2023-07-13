// to generate random numbers we will import math package
import 'dart:math';
import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  // this create state function returns State object
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/dice-1.png';
  void roll() {
    // we will use random constructor function which is officially provided by dart.math package that provides various packages to create
    // random numbers and it has a method named nextInt that takes input of integer values but only max value like 6 then it runs from 0 to 5
    var diceRoll = Random().nextInt(6) + 1;
    // in this after doing this the pic will not get changed so we use setState widget and this is only available in state widget of <>
    //that set state widget is re executes the build function
    setState(() {
      activeDiceImage = 'assets/dice-$diceRoll.png';
      // here we inject integer function inside a path by using $ along with the variable in which all the random generated values will store
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ), // sized box is just a widget that is used to give space between dice image and text part of height 20
        TextButton(
          onPressed: roll,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 30,
            ),
          ),
          child: const Text('Roll Dice'),
        ), // in this child is a widget that takes input of the text
        // which is need to be shown on the button and onPressed is the function that handles how the button behaves after get clicked
      ],
    );
  }
}
