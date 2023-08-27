import 'package:flutter/material.dart';
import 'dart:math';

class RollDice extends StatefulWidget {
  const RollDice({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DiceRollState();
  }
}

class _DiceRollState extends State<RollDice> {
  final randomizer = Random();
  static const diceBtn = 'Roll Dice';
  var imageUrl = 'assets/dice-images/dice-1.png';

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        imageUrl,
        width: 200,
      ),
      TextButton(onPressed: rollDice, child: const Text(diceBtn))
    ]);
  }

  void rollDice() {
    setState(() {
      int diceNum = randomizer.nextInt(6) + 1;
      imageUrl = 'assets/dice-images/dice-$diceNum.png';
    });
    print('imageUrl' + imageUrl);
  }
}
