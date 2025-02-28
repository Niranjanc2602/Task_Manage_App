import 'package:flutter/material.dart';
import 'package:sqflite_test/models/Note.dart';
import 'package:sqflite_test/utils/note_data.dart';

class ViewNotesScreen extends StatelessWidget {
  final int epicId;

  const ViewNotesScreen({super.key, required this.epicId});

  @override
  Widget build(BuildContext context) {
    final notes = NoteData.getNotesForEpic(epicId);

    return Scaffold(
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: notes.isEmpty
          ? Center(child: Text('No notes found.'))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.description),
          );
        },
      ),
    );
  }
}