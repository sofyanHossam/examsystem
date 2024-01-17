import 'package:exam_system/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dialog_service.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _showErrorDialog(BuildContext context, String error) async {
    await DialogService.showErrorDialog(context, error);
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      Function(bool) setLoading,
      ) async {
    setLoading(true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );


    } catch (e) {
      // Handle login errors
      print('Error: $e');
      _showErrorDialog(context, "Login failed: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> createAccount(
      String userType,
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      Function(bool) setLoading,
      ) async {
    setLoading(true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .set({
        'email': emailController.text.trim(),
        'userType': userType

        // Add other user data fields as needed
      });

      // Return a value to be used in the then callback
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
      return Future.value();
    } catch (e) {
      // Handle account creation errors
      print('Error01: $e');
      _showErrorDialog(context, "Account creation failed: $e");
      throw e; // Rethrow the exception to propagate the error
    } finally {
      setLoading(false);
    }
  }
}
