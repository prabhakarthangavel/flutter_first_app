import 'package:first_app/resultScren.dart';
import 'package:first_app/startScreen.dart';
import 'package:first_app/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:first_app/questionsScreen.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<QuizApp> {
  Widget? activeScreen;
  List<String> selectedAnswerrs = [];

  @override
  void initState() {
    debugPrint('**initState called');
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      debugPrint('**questionScreen');
      selectedAnswerrs = [];
      activeScreen = QuestionsScreen(chooseAnswer);
    });
  }

  void setStartScreen() {
    activeScreen = StartScreen(switchScreen);
  }

  void setResultScreen(List<String> answers) {
    debugPrint('**setResultScreen CALLED');

    activeScreen = ResultScreen(switchScreen, answers);
  }

  void chooseAnswer(String answer) {
    selectedAnswerrs.add(answer);
    if (selectedAnswerrs.length == questions.length) {
      setState(() {
        debugPrint('**selectedAnswerrs $selectedAnswerrs');
        setResultScreen(selectedAnswerrs);
        debugPrint('**activeScreen $activeScreen');
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 78, 13, 151),
        Color.fromARGB(255, 107, 15, 168)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: activeScreen,
    )));
  }
}
