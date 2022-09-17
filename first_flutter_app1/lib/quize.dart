import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;    //bcz there is argument to pass...
  final List<Map<String,Object>> questions;
  final int questionIndex;

//in this 'required' means it is mandatory to pass these variable valu...
  Quiz({required this.answerQuestion,required this.questions,required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
              //ternary operator
              children: [
                Question(questions[questionIndex]['questionText']
                    as String), // question[row][column]
                // RaisedButton(
                //   child: Text('Answer 1'),
                //   onPressed:_answerQuestion,//type_1 function
                // ),
                // RaisedButton(
                //   child: Text('Answer 2'),
                //   onPressed: ()=>print('Answe 2 pressed'),//type_2 function
                // ),
                // RaisedButton(
                //   child: Text('Answer 3'),
                //   onPressed: (){
                //     print('Answer 3 pressed');//type_3 function
                //   },
                // )
                ...(questions[questionIndex]['answers'] as List<Map<String,Object>>)
                    .map((answer) {
                  return Answer(()=>answerQuestion(answer['score']), answer['text'] as String);
                }).toList()
              ],
            );//column
    
  }
}