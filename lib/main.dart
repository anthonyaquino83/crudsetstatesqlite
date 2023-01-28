import 'package:crudsetstatesqlite/api/notes_database.dart';
import 'package:crudsetstatesqlite/controllers/notes_controller.dart';
import 'package:crudsetstatesqlite/repositories/notes_repository.dart';
import 'package:flutter/material.dart';

import 'app/notes_app.dart';

//* 1 - importar dependências sqflite e path
//* 2 - separação dos primeiros widgets
//* criar pasta app e pasta pages
//* criar arquivos notes_app.dart e notes_list_page.dart
//* 3 - criar model
//* criar pasta models
//* criar arquivo note.dart
//* 4 - criar api
//* criar pasta api
//* criar arquivo notes_database.dart
//* 5 - criar repository
//* criar pasta repositories
//* criar arquivo notes_repository.dart
//* 6 - criar controller
//* criar pasta controllers
//* criar arquivo notes_controller.dart
//* 7 - instanciar repository e controller
//* 8 - receber o parâmetro controller na lista de notas
//* 9 - criar estados da lista de notas
//* 10 - criar função para recuperar as notas
//* 11 - gerenciar os estados da lista de notas
//* 12 - testar os estados de loading, sucesso e erro
//* 13 - implementar pull to refresh
//* 14 - criar note edit page
//* 15 - criar navegação para inserir nota com o FAB
//* 16 - criar funcionalidade de inserir nota
//* 17 - mostrar loading ao inserir nota
//* 18 - criar listview da lista de notas
//* 19 - atualizar lista de notas depois de inserir nota
//* 20 - criar navegação para editar nota
//* 21 - criar funcionalidade de atualizar nota
//* 22 - criar funcionalidade de excluir nota com o Dismissible
//* 23 - solicitar confirmação ao excluir nota
//* 24 - criar funcionalidade de excluir todas as notas
//* 25 - solicitar confirmação ao excluir nota
//* 26 - testar mensagens de erro

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = NotesRepository(db: NotesDatabase.instance);
  final controller = NotesController(repository: repository);
  runApp(NotesApp(controller: controller));
}
