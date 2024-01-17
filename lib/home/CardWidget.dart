import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login/LoginPage.dart';

class CardWidget extends StatelessWidget {
  final String name;

  CardWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(passedString: "${name}"),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            name,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}