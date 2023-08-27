import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple.shade900,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset('assets/quiz-logo.png', width: 250)],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Padding(padding: EdgeInsets.only(top: 50)),
            Text('Learn Fulttter the fun way',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton( 
                onPressed: startQuiz, 
                child: const Text('-> Start Quiz', style: TextStyle(color: Colors.white)))
            ],
          )
        ]));
  }

  void startQuiz() {}
}



