// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:crudsetstatesqlite/api/notes_database.dart';

import '../models/note.dart';

class NotesRepository {
  final NotesDatabase db;
  NotesRepository({
    required this.db,
  });

  Future<List<Note>> getNotes() async {
    List<Note> notes = await db.getNotas();
    return notes;
  }

  Future<void> saveNote(String description) async {
    Note note = Note(description: description);
    await db.save(note);
  }

  Future<void> updateNote(Note note) async {
    await db.update(note);
  }

  Future<void> removeNote(int id) async {
    await db.delete(id);
  }

  Future<void> removeNotes() async {
    await db.deleteAll();
  }
}
