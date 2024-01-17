
import 'package:exam_system/student/exam/question_widget.dart';
import 'package:exam_system/student/exam/score_collector.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamPageForStudents extends StatefulWidget {
  final String examId;

  ExamPageForStudents({required this.examId});

  @override
  _ExamPageForStudentsState createState() => _ExamPageForStudentsState();
}

class _ExamPageForStudentsState extends State<ExamPageForStudents> {
  final TextEditingController nameController = TextEditingController();
  List<Map<String, dynamic>> userAnswers = [];
  bool _savingData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Page for Students'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('exams').doc(widget.examId).collection('questions').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No questions found.'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var questionData = snapshot.data!.docs[index].data();
                      String questionText = questionData['questionText'];
                      List<String> answers = List<String>.from(questionData['answers']);
                      answers.shuffle();

                      return QuestionWidget(
                        questionText: questionText,
                        answers: answers,
                        onAnswerSelected: (selectedAnswer) {
                          userAnswers.add({'questionIndex': index, 'selectedAnswer': selectedAnswer});
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Enter Your Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _savingData
                        ? null
                        : () => ScoreCollector.collectScore(
                      context,
                      snapshot,
                      nameController,
                      userAnswers,
                      widget.examId,
                          (saving) {
                        setState(() {
                          _savingData = saving;
                        });
                      },
                    ),
                    child: _savingData ? CircularProgressIndicator() : Text('Collect Score'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}









