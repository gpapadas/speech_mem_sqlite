import 'package:flutter/material.dart';
import 'package:speech_mem_sqlite/widgets/transcription_tile.dart';
import 'package:speech_mem_sqlite/models/transcription.dart';
import 'package:intl/intl.dart';

class TranscriptionsList extends StatefulWidget {
  TranscriptionsList(this.snapshot);

  final snapshot;

  @override
  _TranscriptionsListState createState() => _TranscriptionsListState();
}

class _TranscriptionsListState extends State<TranscriptionsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.snapshot.data.length,
      itemBuilder: (context, index) {
        Transcription transcription = widget.snapshot.data[index];
        return TranscriptionTile(
          transcriptionName: transcription.name,
          transcriptionDate: DateFormat('dd/MM/yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(
              transcription.datetime,
            ),
          ),
        );
      },
    );
  }
}
