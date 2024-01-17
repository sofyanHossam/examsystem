import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDataSaver {
  static Future<void> saveUserData(
      BuildContext context, TextEditingController nameController, int score, String examId) async {
    if (nameController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('user_results').add({
        'name': nameController.text,
        'score': score,
        'examId': examId,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter your name')));
    }
  }
}
