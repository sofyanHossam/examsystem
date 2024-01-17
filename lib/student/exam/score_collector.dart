import 'package:exam_system/student/exam/score_calculator.dart';
import 'package:exam_system/student/exam/score_dialog.dart';

import 'package:exam_system/student/exam/user_data_saver.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ScoreCollector {
  static Future<void> collectScore(
      BuildContext context,
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      TextEditingController nameController,
      List<Map<String, dynamic>> userAnswers,
      String examId,
      Function(bool) setSavingData,
      ) async {
    setSavingData(true);

    int score = ScoreCalculator.calculateScore(snapshot.data!.docs.length, snapshot, userAnswers);

    await UserDataSaver.saveUserData(context, nameController, score, examId);

    setSavingData(false);

    ScoreDialog.showScoreDialog(context, score);
  }
}
