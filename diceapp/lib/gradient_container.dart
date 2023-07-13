import 'package:diceapp/dice_roller.dart';
import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// if we want to change the data in between the function as we want we can not use stateless widget we must use stateful widget
class GradientContainer extends StatelessWidget {
  GradientContainer({super.key});
  // for creating random roll dice app we should have to make a var variable that can change it's value

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.deepPurple,
          Colors.white,
        ], begin: startAlignment, end: endAlignment),
      ),
      child: Center(
          // as it takes whole bottom space then to solve that we use maxAxisSize that handles the space on the screen
          //there are two options with that first one is min and second is max, min means minimum to minimum space will be given and
          // max means it takes maximum space as possible
          child: DiceRoller()),
    );
  }
}
