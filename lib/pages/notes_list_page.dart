import 'package:crudsetstatesqlite/controllers/notes_controller.dart';
import 'package:crudsetstatesqlite/helpers/confirmation_dialog.dart';
import 'package:crudsetstatesqlite/pages/note_edit_page.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';

enum NotesStatus { loading, success, failure }

class NotesListPage extends StatefulWidget {
  const NotesListPage({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final NotesController controller;

  @override
  State<NotesListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NotesListPage> {
  NotesStatus state = NotesStatus.loading;
  List<Note> notes = <Note>[];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<void> getNotes() async {
    setState(() {
      state = NotesStatus.loading;
    });
    await widget.controller
        .getNotes()
        .then((value) => setState(
              () {
                notes = value;
                state = NotesStatus.success;
              },
            ))
        .onError((error, stackTrace) => setState(
              () {
                errorMessage = error.toString();
                state = NotesStatus.failure;
              },
            ));
  }

  Future<void> removeNote(id) async {
    setState(() {
      state = NotesStatus.loading;
    });
    await widget.controller.removeNote(id).then((value) async {
      const snackBar = SnackBar(content: Text('Nota excluída com sucesso.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await getNotes();
    }).onError((error, stackTrace) {
      setState(() {
        errorMessage = error.toString();
        state = NotesStatus.failure;
      });
    });
  }

  Future<void> removeNotes() async {
    if (notes.isEmpty) {
      const snackBar = SnackBar(content: Text('Não há notas para excluir.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        state = NotesStatus.loading;
      });
      await widget.controller.removeNotes().then((value) async {
        const snackBar =
            SnackBar(content: Text('Notas excluídas com sucesso.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          notes = [];
          state = NotesStatus.success;
        });
      }).onError((error, stackTrace) {
        setState(() {
          errorMessage = error.toString();
          state = NotesStatus.failure;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                if (await showConfirmationDialog(context) == true) {
                  await removeNotes();
                }
              },
              icon: const Icon(Icons.clear_all))
        ],
      ),
      body: Builder(builder: (context) {
        switch (state) {
          case NotesStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case NotesStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(errorMessage),
                  ElevatedButton(
                    onPressed: () async => await getNotes(),
                    child: const Text('Atualizar'),
                  )
                ],
              ),
            );
          case NotesStatus.success:
            if (notes.isEmpty) {
              return const Center(
                child: Text('Não há notas cadastradas.'),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => await getNotes(),
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  Note note = notes[index];
                  return Dismissible(
                    background: Container(color: Colors.blue),
                    key: ObjectKey(note),
                    child: ListTile(
                      title: Text('${note.id} - ${note.description}'),
                      onTap: () async {
                        final bool? refresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => NoteEditPage(
                                      note: note,
                                      controller: widget.controller,
                                    ))));
                        if (refresh == true) {
                          getNotes();
                        }
                      },
                    ),
                    confirmDismiss: (direction) async {
                      if (await showConfirmationDialog(context) == true) {
                        await removeNote(note.id);
                        return true;
                      } else {
                        return false;
                      }
                    },
                  );
                },
              ),
            );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? refresh = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => NoteEditPage(
                        note: null,
                        controller: widget.controller,
                      ))));
          if (refresh == true) {
            getNotes();
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
