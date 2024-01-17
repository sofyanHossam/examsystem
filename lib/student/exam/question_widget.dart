// question_widget.dart

import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final String questionText;
  final List<String> answers;
  final ValueChanged<String> onAnswerSelected;

  QuestionWidget({
    required this.questionText,
    required this.answers,
    required this.onAnswerSelected,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.questionText,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: widget.answers.map((answer) {
              return RadioListTile(
                title: Text(answer),
                value: answer,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value.toString();
                    widget.onAnswerSelected(selectedAnswer!);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
