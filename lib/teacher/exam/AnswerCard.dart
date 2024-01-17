import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final ValueChanged<String> onAnswerChanged;
  final String answerHint;

  AnswerCard({required this.answer, required this.onAnswerChanged,required this.answerHint});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: onAnswerChanged,
              decoration: InputDecoration(
                hintText: answerHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}