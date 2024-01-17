import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ScoreCalculator {
  static int calculateScore(int totalQuestions, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, List<Map<String, dynamic>> userAnswers) {
    int score = 0;
    for (var answer in userAnswers) {
      if (answer['selectedAnswer'] == snapshot.data!.docs[answer['questionIndex']].data()!['answers'][0]) {
        score++;
      }
    }
    return score;
  }
}
