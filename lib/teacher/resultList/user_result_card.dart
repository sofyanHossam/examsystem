// user_result_card.dart

import 'package:flutter/material.dart';

class UserResultCard extends StatelessWidget {
  final String name;
  final int score;
  final String examId;

  UserResultCard({required this.name, required this.score, required this.examId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Exam ID: $examId'),
        trailing: Text('Score: $score'),
      ),
    );
  }
}
