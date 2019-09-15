import 'package:speech_mem_sqlite/models/transcription.dart';
import 'package:speech_mem_sqlite/data/database_creator.dart';

class RepositoryServiceTranscription {
  static Future<List<Transcription>> getAllTranscriptions() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.transcriptionTable}
    WHERE ${DatabaseCreator.isDeleted} = 0''';
    final data = await db.rawQuery(sql);
    List<Transcription> transcriptions = List();

    for (final node in data) {
      final transcription = Transcription.fromJson(node);
      transcriptions.add(transcription);
    }
    return transcriptions;
  }

  static Future<Transcription> getTranscription(int id) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.transcriptionTable}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final transcription = Transcription.fromJson(data.first);
    return transcription;
  }

  static Future<void> addTranscription(Transcription transcription) async {
    final sql = '''INSERT INTO ${DatabaseCreator.transcriptionTable}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.name},
      ${DatabaseCreator.datetime},
      ${DatabaseCreator.isDeleted}
    )
    VALUES (?,?,?,?)''';
    List<dynamic> params = [transcription.id, transcription.name, transcription.datetime, transcription.isDeleted ? 1 : 0];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add transcription', sql, null, result, params);
  }

  static Future<void> deleteTranscription(Transcription transcription) async {
    final sql = '''UPDATE ${DatabaseCreator.transcriptionTable}
    SET ${DatabaseCreator.isDeleted} = 1
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [transcription.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete transcription', sql, null, result, params);
  }

  static Future<void> updateTranscription(Transcription transcription) async {
    final sql = '''UPDATE ${DatabaseCreator.transcriptionTable}

    SET ${DatabaseCreator.name} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [transcription.name, transcription.id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Update transcription', sql, null, result, params);
  }

  static Future<int> transcriptionsCount() async {
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.transcriptionTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;

    return idForNewItem;
  }
}