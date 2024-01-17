import 'package:exam_system/teacher/ExamScreen.dart';
import 'package:flutter/material.dart';
import 'resultList/user_results_list.dart';


class UserResultsScree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Results'),
      ),
      body: UserResultsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExamScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
