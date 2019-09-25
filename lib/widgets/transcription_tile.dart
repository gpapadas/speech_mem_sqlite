import 'package:flutter/material.dart';
import 'package:speech_mem_sqlite/screens/transcription_edit.dart';

class TranscriptionTile extends StatelessWidget {
  TranscriptionTile({this.transcriptionName, this.transcriptionDate});

  //final bool isChecked;
  final String transcriptionName;
  final String transcriptionDate;
  //final Function checkboxCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TranscriptionEdit(transcriptionName),
        ));
      },
      child: ListTile(
        title: Text(
          transcriptionName,
        ),
        trailing: Text(
          transcriptionDate,
        ),
      ),
    );
  }
}
