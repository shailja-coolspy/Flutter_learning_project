import 'dart:ffi';

import 'package:first_flutter_app1/quize.dart';
import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import './quize.dart';
import './result.dart';

// void main() {
// runApp(MyApp());

// }

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: Text('My First App'),
//       ),
//       body: Text('This is my default text'),
//     ));
//   }
// }

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState(); //connection setup from both side
  }
}

//"_" will change public to private so that property inside this class cannot be acessed from anywhere else...
class _MyAppState extends State<MyApp> {
  //it tells this state belong to MyApp class..

  var _questionIndex = 0;
  var _totalScore= 0;

  void _resetQuize(){
    setState(() {
      _questionIndex=0;
      _totalScore=0;
    });
  }

  final _questions = const [
    {
      'questionText': 'What\'s your favourate colour?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 4},
        {'text': 'Blue', 'score': 2}
      ]
    }, //Map<key,value> short-cut.....
    {
      'questionText': 'What\'s your favourate animal?',
      'answers': [
        {'text': 'Dog', 'score': 20},
        {'text': 'Lion', 'score': 15},
        {'text': 'Elephant', 'score': 10},
        {'text': 'Hourse', 'score': 5}
      ]
    },
    {
      'questionText': 'What\'s your favourate instructor?',
      'answers': [
        {'text': 'Max', 'score': 4},
        {'text': 'Manu', 'score': 3},
        {'text': 'Raj', 'score': 2},
        {'text': 'Striver', 'score': 1}
      ]
    },
  ]; //List

  void _answerQuestion(int score) {

    _totalScore=_totalScore+score;

    setState(() {
      //it is method or function in State class
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questions: _questions,
              questionIndex: _questionIndex)
          : Result(_totalScore,_resetQuize),
    ));
  }
}
