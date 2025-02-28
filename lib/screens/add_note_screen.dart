import 'package:flutter/material.dart';
import 'package:sqflite_test/models/Note.dart';
import 'package:sqflite_test/utils/note_data.dart';

class AddNoteScreen extends StatefulWidget {
  final int epicId;

  const AddNoteScreen({super.key, required this.epicId});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _addNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        epicId: widget.epicId,
        description: _descriptionController.text,
      );
      NoteData.addNote(note);
      Navigator.pop(context);
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