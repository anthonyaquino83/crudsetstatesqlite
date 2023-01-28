import 'package:crudsetstatesqlite/controllers/notes_controller.dart';
import 'package:flutter/material.dart';

import '../pages/notes_list_page.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key, required this.controller});
  final NotesController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD SetState SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesListPage(
        title: 'CRUD SetState SQLite',
        controller: controller,
      ),
    );
  }
}
