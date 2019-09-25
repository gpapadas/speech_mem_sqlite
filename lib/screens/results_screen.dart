import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_mem_sqlite/models/transcription.dart';
import 'package:speech_mem_sqlite/data/repository_service_transcription.dart';
import 'package:speech_mem_sqlite/widgets/transcriptions_list.dart';

class ResultsScreen extends StatefulWidget {
  static const String id = 'success_screen';

  ResultsScreen({this.resultText, this.transcriptionId});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // RaisedButton(
          //   child: Text('Read last record'),
          //   onPressed: readTranscription,
          // ),
          // SizedBox(
          //   height: 20.0,
          // ),
          // Container(
          //   child: Text('${transcriptionName ?? ""}'),
          // ),
          // SizedBox(
          //   height: 20.0,
          // ),
          // RaisedButton(
          //   child: Text('Read all records'),
          //   onPressed: readTranscription,
          // ),
          // SizedBox(
          //   height: 20.0,
          // ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TranscriptionsList(snapshot);
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // Card buildItem(Transcription transcription) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             'Transcription: ${transcription.name}',
  //             style: TextStyle(fontSize: 15),
  //           ),
  //           Text(
  //             'Date: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(transcription.datetime))}',
  //             style: TextStyle(fontSize: 15),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
//   }
}

// updateTranscription(Transcription transcription) async {
//   transcription.name = 'updated record';
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
