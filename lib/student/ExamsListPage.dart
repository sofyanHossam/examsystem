import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_system/splash/SplashScreen.dart';
import 'package:exam_system/student/examsList/firesrore_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ExamPageForStudent.dart';


class ExamsListPage extends StatefulWidget {
  @override
  _ExamsListPageState createState() => _ExamsListPageState();
}

class _ExamsListPageState extends State<ExamsListPage> {
  late Future<List<QueryDocumentSnapshot>?> examsFuture;

  @override
  void initState() {
    super.initState();
    examsFuture = getExamsData();
  }

  // Function to handle logout
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    ); // Replace with your home route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exams List'),
        actions: [
          // Add a logout button in the app bar
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: FutureBuilder(
        future: examsFuture,
        builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Text('Error fetching exams');
          }
          var exams = snapshot.data!;
          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context, index) {
              var exam = exams[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamPageForStudents(examId: exam.id),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(exam['examName']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
