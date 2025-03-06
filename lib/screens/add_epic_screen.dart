import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/dao/Epic_dao.dart';
import 'package:sqflite_test/models/Epic.dart';

class AddEpicScreen extends StatefulWidget {
  @override
  _AddEpicScreenState createState() => _AddEpicScreenState();
}

class _AddEpicScreenState extends State<AddEpicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();
  final EpicDao _epicDao = EpicDao(); // Create an EpicDao instance

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final epic = Epic(
        name: _nameController.text,
        description: _descriptionController.text,
        status: Status.todo,
        priority: int.tryParse(_priorityController.text) ?? 0,
      );

      try {
        // Insert the epic into the database
        int epicId = await _epicDao.insert(epic);
        // If the insertion is successful, pop the screen with the new epic's ID
        Navigator.pop(context, epicId);
      } catch (e) {
        // Handle database insertion errors
        print('Error inserting epic: $e');
        // You might want to show an error message to the user here
        Navigator.pop(context, null); // Pop with null to indicate an error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Epic'),
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
              TextFormField(
                controller: _priorityController,
                decoration: InputDecoration(labelText: 'Priority'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a priority';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
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