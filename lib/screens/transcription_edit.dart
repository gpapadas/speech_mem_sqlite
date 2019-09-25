import 'package:flutter/material.dart';

class TranscriptionEdit extends StatelessWidget {
  TranscriptionEdit(this.transcriptionName);

  final transcriptionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  transcriptionName,
                  style: TextStyle(fontSize: 25.0,),
                ),
              ),
        ),
      ),
    );
  }
}