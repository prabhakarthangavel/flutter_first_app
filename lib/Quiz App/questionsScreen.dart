import 'package:first_app/Quiz%20App/answerButton.dart';
import 'package:first_app/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/quiz_questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.onSelectAnser, {super.key});
  final void Function(String answer) onSelectAnser;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  
  void answerQuestion(String selectedAnswerrs) {
    widget.onSelectAnser(selectedAnswerrs);
    //setstate will reexecute the build()
    setState(() {
      //incremeting question index moving to next question
      currentQuestionIndex += 1;
    });
  }


  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex]; 
    
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(currentQuestion.text, style: GoogleFonts.lato(color: const Color.fromARGB(255, 201, 153, 251), fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
          const SizedBox(height: 30),
          ...currentQuestion.getShuffledAnswers().map((String answer) {
            return AnswerButton(answer, () {answerQuestion(answer);});
          })
        ]),
      ),
    );
  }
}
