import 'package:flutter/material.dart';
import 'RollDice.dart';

const startAlignment = Alignment.topLeft;
var endALignment = Alignment.bottomRight;

class MyApp extends StatelessWidget {
  MyApp(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: startAlignment,
              end: endALignment,
            ),
          ),
          child: const Center(child: RollDice()),
        ),
      ),
    );
  }
}

class StyleText extends StatelessWidget {
  const StyleText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
    );
  }
}
