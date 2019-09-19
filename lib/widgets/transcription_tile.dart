import 'package:flutter/material.dart';

class TranscriptionTile extends StatelessWidget {
  TranscriptionTile({this.transcriptionName, this.transcriptionDate});

  //final bool isChecked;
  final String transcriptionName;
  final String transcriptionDate;
  //final Function checkboxCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        transcriptionName,
        // style: TextStyle(
        //   decoration:
        //       isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        // ),
      ),
      trailing: Text(
        transcriptionDate,
      ),
      // trailing: Checkbox(
      //   activeColor: Colors.lightBlueAccent,
      //   value: isChecked,
      //   onChanged: checkboxCallback,
      // ),
    );
  }
}
