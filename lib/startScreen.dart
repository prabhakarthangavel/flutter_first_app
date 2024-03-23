import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/quiz-logo.png', width: 250),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Text('Learn Flutter the fun way',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        const Padding(padding: EdgeInsets.only(top: 25)),
        OutlinedButton.icon(
            onPressed: startQuiz,
            icon: const Icon(Icons.arrow_right_alt, color: Colors.white),
            label:
                const Text('Start Quiz', style: TextStyle(color: Colors.white)))
      ],
    ));
  }

}
