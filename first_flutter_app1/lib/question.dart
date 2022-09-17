import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;                       //final it tell data will not be changed
  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(                             // container is like "<dir>" in html...
        width: double.infinity,
        margin: EdgeInsets.all(9.2),
        child: Text(
          questionText,//question
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
