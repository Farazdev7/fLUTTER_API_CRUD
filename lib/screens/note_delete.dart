import 'package:flutter/material.dart';

class NoteDeleteDialogue extends StatelessWidget {
  const NoteDeleteDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warning'),
      content: const Text('Are you sure'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes')),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No')),
      ],
    );
  }
}
