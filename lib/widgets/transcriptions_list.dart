import 'package:flutter/material.dart';
import 'package:speech_mem_sqlite/widgets/transcription_tile.dart';

class TranscriptionsList extends StatefulWidget {
  @override
  _TranscriptionsListState createState() => _TranscriptionsListState();
}

class _TranscriptionsListState extends State<TranscriptionsList> {
  // List<Task> tasks = [
  //   Task(name: 'Buy milk'),
  //   Task(name: 'Buy eggs'),
  //   Task(name: 'Buy bread'),
  // ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TranscriptionTile(
          //isChecked: tasks[index].isDone,
          transcriptionName: 'name',
          transcriptionDate: 'date' ,
        );
      },
      itemCount: 5,
    );
  }
}
