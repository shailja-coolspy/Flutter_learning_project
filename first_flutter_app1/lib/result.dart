
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resultHandler;

  Result(this.resultScore, this.resultHandler);

  String get resultPhase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awsome and innocent !!';
    } else if (resultScore <= 12) {
      resultText = 'Pretty like able!!';
    } else if (resultScore <= 16) {
      resultText = 'You are strange...!!';
    } else {
      resultText = 'You are bad..!!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text('Reset Quiz!!'),
          textColor: Colors.blue,
          onPressed: resultHandler,
        )
      ],
    ));
  }
}
