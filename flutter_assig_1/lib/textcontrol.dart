

import 'package:flutter/material.dart';
import'textOutput.dart';

class TextControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextControlState();
  }
}

class _TextControlState extends State<TextControl> {
  String _mainText = 'Shailja Agarwal';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                _mainText = "Anshuman Agarwal";
              });
            },
            child: const Text('Change Text')),
        TextOutput(_mainText),
      ],
    );
  }
}
