import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_result_card.dart';

class UserResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user_results').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No user results found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var userResultData = snapshot.data!.docs[index].data();
              String name = userResultData['name'];
              int score = userResultData['score'];
              String examId = userResultData['examId'];

              return UserResultCard(
                name: name,
                score: score,
                examId: examId,
              );
            },
          );
        }
      },
    );
  }
}
