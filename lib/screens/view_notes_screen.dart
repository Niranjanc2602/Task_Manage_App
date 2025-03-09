import 'package:flutter/material.dart';
import 'package:sqflite_test/dao/Note_dao.dart';
import 'package:sqflite_test/models/Note.dart';

class ViewNotesScreen extends StatefulWidget {
  final int epicId;
  final int? userStoryId;
  final int? taskId;

  const ViewNotesScreen({super.key, required this.epicId, this.userStoryId, this.taskId});

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  final NoteDao _noteDao = NoteDao();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    List<Note> notes = [];

    if (widget.taskId != null) {
      notes = await _noteDao.getNotesByTaskId(widget.taskId!);
    } else if (widget.userStoryId != null) {
      notes = await _noteDao.getNotesByUserStoryId(widget.userStoryId!);
    } else {
      notes = await _noteDao.getNotesByEpicId(widget.epicId);
    }

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