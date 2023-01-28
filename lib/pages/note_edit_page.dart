import 'package:crudsetstatesqlite/controllers/notes_controller.dart';
import 'package:flutter/material.dart';

import '../helpers/loading_dialog.dart';
import '../models/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({
    super.key,
    required this.note,
    required this.controller,
  });
  final Note? note;
  final NotesController controller;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noteFieldController = TextEditingController();

  Future<void> insertNote(String description) async {
    FocusScope.of(context).unfocus();
    showLoadingDialog(context);
    await widget.controller.saveNote(description).then((value) {
      Navigator.pop(context);
      const snackBar = SnackBar(content: Text('Nota incluída com sucesso.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, true);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      SnackBar snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> updateNote(Note note) async {
    FocusScope.of(context).unfocus();
    showLoadingDialog(context);
    await widget.controller.updateNote(note).then((value) {
      Navigator.pop(context);
      const snackBar = SnackBar(content: Text('Nota atualizada com sucesso.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, true);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      SnackBar snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void initState() {
    super.initState();
    noteFieldController.text = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.note == null
            ? const Text('Inserir Nota')
            : const Text('Atualizar Nota'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: noteFieldController,
                validator: ((value) => (value == null || value.isEmpty)
                    ? 'Campo Obrigatório'
                    : null),
                onFieldSubmitted: (_) async {
                  if (_formKey.currentState!.validate()) {
                    widget.note == null
                        ? await insertNote(noteFieldController.text)
                        : await updateNote(Note(
                            id: widget.note!.id,
                            description: noteFieldController.text,
                          ));
                  }
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.note == null
                          ? await insertNote(noteFieldController.text)
                          : await updateNote(Note(
                              id: widget.note!.id,
                              description: noteFieldController.text,
                            ));
                    }
                  },
                  child: const Text('Salvar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
