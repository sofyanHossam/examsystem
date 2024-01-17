import 'package:flutter/material.dart';

class ScoreDialog {
  static Future<void> showScoreDialog(BuildContext context, int score) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Your Score'),
          content: Text('Your score is: $score'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
