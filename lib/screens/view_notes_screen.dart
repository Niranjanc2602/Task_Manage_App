import 'package:flutter/material.dart';
import 'package:sqflite_test/dao/Note_dao.dart';
import 'package:sqflite_test/models/Note.dart';

class ViewNotesScreen extends StatefulWidget {
  final int epicId;

  const ViewNotesScreen({super.key, required this.epicId});

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  final NoteDao _noteDao = NoteDao(); // Create a NoteDao instance
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await _noteDao.getNotesByEpicId(widget.epicId);
    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Notes'),
      ),
      body: _notes.isEmpty
          ? Center(child: Text('No notes found.'))
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return ListTile(
            title: Text(note.description),
          );
        },
      ),
    );
  }
}