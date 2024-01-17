import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<QueryDocumentSnapshot>?> getExamsData() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('exams').get();
    return snapshot.docs;
  } catch (e) {
    print('Error fetching exams: $e');
    return null;
  }
}