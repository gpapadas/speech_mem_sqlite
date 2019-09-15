import 'package:speech_mem_sqlite/data/database_creator.dart';

class Transcription {
  int id;
  String name;
  int datetime;
  bool isDeleted;

  Transcription(this.id, this.name, this.datetime, this.isDeleted);

  Transcription.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.datetime = json[DatabaseCreator.datetime];
    this.isDeleted = json[DatabaseCreator.isDeleted] == 1;
  }
}