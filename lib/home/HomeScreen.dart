import 'package:flutter/material.dart';
import 'CardWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(name: 'Student'),
            SizedBox(height: 16),
            CardWidget(name: 'Teacher'),
          ],
        ),
      ),
    );
  }
}

