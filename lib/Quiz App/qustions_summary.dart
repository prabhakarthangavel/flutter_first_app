import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            bool isAnswerValid = data['user_answer'] == data['correct_answer'];
            debugPrint('**answerdata $data');
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  CircleAvatar(
                      radius: 13,
                      backgroundColor: (isAnswerValid)
                          ? const Color.fromARGB(255, 146, 253, 217)
                          : const Color.fromARGB(255, 244, 124, 255),
                      child: Text(
                        ((data['question_index'] as int) + 1).toString(),
                        style: const TextStyle(color: Colors.black),
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                    width: 286,
                    child: Text(data['question'] as String,
                        style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 229, 209, 250),
                            fontSize: 15,
                            fontWeight: FontWeight.bold))),
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 3),
                    width: 280,
                    child: Text(data['user_answer'] as String,
                        style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 201, 153, 251),
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 3),
                    width: 280,
                    child: Text(data['correct_answer'] as String,
                        style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 146, 253, 217),
                            fontSize: 12,
                            fontWeight: FontWeight.bold)))
              ])
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
