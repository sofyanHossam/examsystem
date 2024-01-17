import 'package:flutter/material.dart';
import 'package:exam_system/teacher/exam/AnswerCard.dart';
import 'package:exam_system/teacher/exam/Question.dart';



class QuestionWidget extends StatelessWidget {
  final Question question;
  final VoidCallback onAddQuestion;

  QuestionWidget({required this.question, required this.onAddQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TextField(
          onChanged: (text) {
            question.questionText = text;
          },
          decoration: InputDecoration(
            hintText: 'Enter question',
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: question.answers.length,
          itemBuilder: (context, index) {
            if(index ==0){
              return AnswerCard(
                answer: question.answers[index],
                answerHint: "Enter Correct Answer",
                onAnswerChanged: (text) {
                  question.answers[index] = text;
                },
              );
            }
            return AnswerCard(
              answer: question.answers[index],
              answerHint: "Enter Wrong Answer",
              onAnswerChanged: (text) {
                question.answers[index] = text;
              },
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onAddQuestion,
        ),
      ],
    );
  }
}