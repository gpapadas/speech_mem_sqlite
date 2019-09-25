import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:speech_mem_sqlite/screens/record_screen.dart';
import 'package:speech_mem_sqlite/screens/results_screen.dart';
import 'package:speech_mem_sqlite/data/database_creator.dart';

// void main() => runApp(MyApp());

void main() async {
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RecordScreen.id,
      routes: {
        RecordScreen.id: (context) => RecordScreen(),
        ResultsScreen.id: (context) => ResultsScreen(),
      },
      //home: RecordScreen(storage: Storage(),),
    );
  }
}