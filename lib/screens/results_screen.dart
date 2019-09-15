import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_mem_sqlite/models/transcription.dart';
import 'package:speech_mem_sqlite/data/repository_service_transcription.dart';

class ResultsScreen extends StatefulWidget {
  static const String id = 'success_screen';

  ResultsScreen(
      {this.resultText, this.transcriptionId});

  final String resultText;
  final int transcriptionId;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  String transcriptionName;
  String transcriptionDate;

  Future<List<Transcription>> future;
  String name;

  @override
  void initState() {
    super.initState();
    future = RepositoryServiceTranscription.getAllTranscriptions();
  }

  void readTranscription() async {
    final transcription = await RepositoryServiceTranscription.getTranscription(
        widget.transcriptionId);
    setState(() {
      transcriptionName = transcription.name;
      // var format = DateFormat('yMd');
      // transcriptionDate = format.format(DateTime.fromMillisecondsSinceEpoch(transcription.datetime));
    });
    print(transcription.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Text(widget.resultText,
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('Read last record'),
                  onPressed: readTranscription,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Text('${transcriptionName ?? "File is empty"}'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('Read all records'),
                  onPressed: readTranscription,
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder<List<Transcription>>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data
                              .map((transcription) => buildItem(transcription))
                              .toList());
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildItem(Transcription transcription) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Transcription: ${transcription.name}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Date: ${transcription.datetime}',
              style: TextStyle(fontSize: 15),
            ),
            // SizedBox(height: 12),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     FlatButton(
            //       onPressed: () => updateTranscription(transcription),
            //       child: Text('Update todo', style: TextStyle(color: Colors.white)),
            //       color: Colors.green,
            //     ),
            //     SizedBox(width: 8),
            //     FlatButton(
            //       onPressed: () => deleteTranscription(transcription),
            //       child: Text('Delete'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

// updateTranscription(Transcription transcription) async {
//   transcription.name = 'please 🤫';
//   await RepositoryServiceTranscription.updateTranscription(transcription);
//   setState(() {
//     future = RepositoryServiceTranscription.getAllTranscriptions();
//   });
// }

// deleteTranscription(Transcription todo) async {
//   await RepositoryServiceTranscription.deleteTranscription(todo);
//   setState(() {
//     id = null;
//     future = RepositoryServiceTranscription.getAllTranscriptions();
//   });
// }

// void readTranscription() {
//   widget.storage.readData().then((String value) {
//     setState(() {
//       data = value;
//     });
//   });
// }