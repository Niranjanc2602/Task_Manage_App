import 'package:flutter/material.dart';
import '../models/UserStory.dart';
import 'package:sqflite_test/constants/Status.dart';

class AddUserStoryScreen extends StatefulWidget {
  final int epicId;

  AddUserStoryScreen({required this.epicId});

  @override
  _AddUserStoryScreenState createState() => _AddUserStoryScreenState();
}

class _AddUserStoryScreenState extends State<AddUserStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final userStory = UserStory(
        name: _nameController.text,
        description: _descriptionController.text, EpiId: widget.epicId,
        status: Status.todo,
        priority: 0
      );
      Navigator.pop(context, userStory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Story'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}