import 'package:crudsetstatesqlite/repositories/notes_repository.dart';

import '../models/note.dart';

class NotesController {
  final NotesRepository repository;
  NotesController({
    required this.repository,
  });

  Future<List<Note>> getNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    return await repository.getNotes();
  }

  Future<void> saveNote(String description) async {
    await Future.delayed(const Duration(seconds: 1));
    await repository.saveNote(description);
  }

  Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(seconds: 1));
    await repository.updateNote(note);
  }

  Future<void> removeNote(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    await repository.removeNote(id);
  }

  Future<void> removeNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    await repository.removeNotes();
  }
}
