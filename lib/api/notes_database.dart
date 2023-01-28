import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  // inicializar banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    // await deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // criar banco de dados
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL
      )
      ''');
  }

  // recuperar notas
  Future<List<Note>> getNotas() async {
    final database = await instance.database;
    // throw Exception('Erro ao buscar todas as notas.');
    final result = await database.rawQuery('SELECT * FROM notes ORDER BY id');
    return result.map((json) => Note.fromJson(json)).toList();
  }

  // salvar nota
  Future<Note> save(Note note) async {
    final database = await instance.database;
    // throw Exception('Erro ao inserir nota.');
    final id = await database.rawInsert(
      'INSERT INTO notes (description) VALUES (?)',
      [note.description],
    );
    print(id);
    return note.copy(id: id);
  }

  // atualizar nota
  Future<Note> update(Note note) async {
    final database = await instance.database;
    // throw Exception('Erro ao atualizar nota.');
    final id = await database.rawUpdate(
        'UPDATE notes SET description = ? WHERE id = ?',
        [note.description, note.id]);
    print(id);
    return note.copy(id: id);
  }

  // excluir nota
  Future<int> delete(int noteId) async {
    final database = await instance.database;
    // throw Exception('Erro ao excluir nota.');
    final id = await database.rawDelete(
      'DELETE FROM notes WHERE ID = ?',
      [noteId],
    );
    return id;
  }

  // excluir notas
  Future<void> deleteAll() async {
    final database = await instance.database;
    // throw Exception('Erro ao excluir todas as notas.');
    await database.rawDelete(
      'DELETE FROM notes',
    );
  }

  // fechar conexão com banco de dados
  Future close() async {
    final database = await instance.database;
    database.close();
  }
}
