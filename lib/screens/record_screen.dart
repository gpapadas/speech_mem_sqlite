import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:speech_mem_sqlite/screens/results_screen.dart';
import 'package:speech_mem_sqlite/models/transcription.dart';
import 'package:speech_mem_sqlite/data/repository_service_transcription.dart';

class RecordScreen extends StatefulWidget {
  static const String id = 'record_screen';

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  bool _transcriptionDone = false;
  bool _isButtonVisible = false;

  String _currentLocale;
  String transcriptionText = '';

  // data that will be written to database
  String data;

  int transcriptionId;

  @override
  void initState() {
    super.initState();

    activateSpeechRecognizer();
  }

  void addTranscription() async {
    if (_transcriptionDone) {
      int count = await RepositoryServiceTranscription.transcriptionsCount();
      final transcription = Transcription(count, transcriptionText,
          DateTime.now().millisecondsSinceEpoch, false);
      await RepositoryServiceTranscription.addTranscription(transcription);
      setState(() {
        transcriptionId = transcription.id;
      });
      print(transcription.id);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            resultText: transcriptionText,
            transcriptionId: transcriptionId,
          ),
        ));
  }

  void activateSpeechRecognizer() {
    _speech = SpeechRecognition();

    _speech.setAvailabilityHandler(
        (bool result) => setState(() => _speechRecognitionAvailable = result));

    // handle device current locale detection
    _speech.setCurrentLocaleHandler(
        (String locale) => setState(() => _currentLocale = locale));

    _speech.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speech.setRecognitionResultHandler((String speech) => setState(() {
          transcriptionText = speech;
          _transcriptionDone = true;
          _isButtonVisible = true;
        }));

    // _speech.setRecognitionCompleteHandler(() {
    //   Future.delayed(Duration(seconds: 1)).then((_) {
    //     _speech.listen(locale: 'el_GR');
    //   });
    // });

    _speech.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    // First launch: speech recognition permission/initialization
    _speech
        .activate()
        .then((result) => setState(() => _speechRecognitionAvailable = result));
  }

  // Speech methods

  void start() =>
      _speech.listen(locale: _currentLocale).then((result) => print('$result'));

  void cancel() => _speech.cancel().then((result) => setState(() {
        _isListening = result;
        transcriptionText = '';
      }));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.cancel),
                  mini: true,
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    // Cancel recording
                    cancel();
                  },
                  heroTag: 'cancel',
                ),
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  onPressed: () {
                    // Start recording
                    if (_speechRecognitionAvailable && !_isListening) {
                      start();
                    }
                  },
                  heroTag: 'start',
                ),
                FloatingActionButton(
                  child: Icon(Icons.stop),
                  mini: true,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    // Stop recording
                    if (_isListening) {
                      _speech.stop().then(
                          (result) => setState(() => _isListening = result));
                    }
                  },
                  heroTag: 'stop',
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% of the width of the entire screen
              // decoration: BoxDecoration(
              //   color: Colors.cyanAccent.shade100,
              //   borderRadius: BorderRadius.circular(6.0),
              // ),

              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Text(transcriptionText),
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: _isButtonVisible,
              child: RaisedButton(
                child: Text('Save'),
                onPressed: addTranscription,
              ),
            ),

            // SizedBox(
            //   height: 20.0,
            // ),
            // RaisedButton(
            //   child: Text('Read file'),
            //   onPressed: readTranscription,
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Container(
            //   child: Text('${data ?? "File is empty"}'),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // RaisedButton(
            //   child: Text('Write file'),
            //   onPressed: writeTranscription,
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // RaisedButton(
            //   child: Text('Save'),
            //   onPressed: () {
            //     if (_transcriptionDone) {
            //       writeTranscription();
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => SuccessScreen(
            //                     resultText: transcription,
            //                     storage: widget.storage,
            //                   )));
            //       // Navigator.pushNamed(context, SuccessScreen.id, arguments: {
            //       //   'resultText': transcription,
            //       // });
            //     }
            //   },
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // RaisedButton(
            //   child: Text('Get Directory'),
            //   onPressed: getAppDirectory,
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // FutureBuilder<Directory>(
            //   future: _appDocDir,
            //   builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
            //     Text text = Text('');
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasError) {
            //         text = Text('Error: ${snapshot.error}');
            //       } else if (snapshot.hasData) {
            //         text = Text('Path: ${snapshot.data.path}');
            //       } else {
            //         text = Text('Unavailable');
            //       }
            //     }
            //     return Container(child: text);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
