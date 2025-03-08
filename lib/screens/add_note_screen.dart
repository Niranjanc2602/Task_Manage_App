import 'package:flutter/material.dart';
import 'package:sqflite_test/models/Note.dart';
import 'package:sqflite_test/utils/note_data.dart';
import 'package:sqflite_test/dao/Note_dao.dart';

class AddNoteScreen extends StatefulWidget {
  final int epicId;
  final int? userStoryId;
  final int? taskId;

  const AddNoteScreen({super.key, required this.epicId, this.userStoryId, this.taskId});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final NoteDao _noteDao = NoteDao();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _addNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        epicId: widget.epicId,
        userStoryId: widget.userStoryId,
        taskId: widget.taskId,
        description: _descriptionController.text,
      );
      try {
        // Insert the note into the database
        int noteId = await _noteDao.insert(note);
        // If the insertion is successful, pop the screen with the new note's ID
        Navigator.pop(context, noteId);
      } catch (e) {
        // Handle database insertion errors
        print('Error inserting note: $e');
        // You might want to show an error message to the user here
        Navigator.pop(context, null); // Pop with null to indicate an error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Note Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a note';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNote,
                child: Text('Add Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}