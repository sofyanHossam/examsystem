
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  static Future<String> getUserType(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      DocumentSnapshot documentSnapshot = await users.doc(userId).get();
      return documentSnapshot['userType'];
    } catch (e) {
      print("Error getting user type: $e");
      return "";
    }
  }
}
