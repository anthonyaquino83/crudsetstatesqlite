import 'package:flutter/material.dart';

showConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmar Exclusão?'),
        content: const Text('Você tem certeza que quer excluir?'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Excluir')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar')),
        ],
      );
    },
  );
}
