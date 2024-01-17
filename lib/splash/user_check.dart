
import 'package:exam_system/teacher/ExamScreen.dart';
import 'package:exam_system/student/ExamsListPage.dart';
import 'package:exam_system/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../teacher/UserResultScreen.dart';
import 'auth_service.dart';

Future<void> checkUser(BuildContext context) async {
  User? user = await AuthService.getCurrentUser();

  await Future.delayed(Duration(seconds: 5));

  if (user != null) {
    String userType = await AuthService.getUserType(user.uid);

    if (userType == "Student") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExamsListPage()),
      );
    } else if (userType == "Teacher") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserResultsScree()),
      );
    }
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
