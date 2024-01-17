import 'package:exam_system/teacher/exam/Question.dart';
import 'package:exam_system/teacher/exam/QuestionWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _examNameController = TextEditingController();
  List<Question> _questions = [Question()]; // Initial question
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exam Name:',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _examNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter exam name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter exam name',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Questions:',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return QuestionWidget(
                      question: _questions[index],
                      onAddQuestion: () {
                        setState(() {
                          _questions.add(Question());
                        });
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    await saveDataToFirestore();
                    setState(() {
                      _isLoading = false;
                    });
                                        Navigator.pop(context); // Navigate back
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference exams = firestore.collection('exams');

    String examName = _examNameController.text.trim();
    List<Map<String, dynamic>> questionsData = [];

    _questions.forEach((question) {
      Map<String, dynamic> questionData = {
        'questionText': question.questionText,
        'answers': question.answers,
      };
      questionsData.add(questionData);
    });

    // Add the exam data to the "exams" collection
    DocumentReference examRef = await exams.add({
      'examName': examName,
    });

    // Create a subcollection named after the exam name
    CollectionReference examNameCollection = examRef.collection('questions');

    // Add the questions data to the subcollection
    questionsData.forEach((questionData) async {
      await examNameCollection.add(questionData);
    });
  }
}



