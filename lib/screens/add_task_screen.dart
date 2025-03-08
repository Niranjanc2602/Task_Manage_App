import 'package:flutter/material.dart';
import 'package:sqflite_test/dao/Task_dao.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/models/Task.dart'; // Import TaskDao

class AddTaskScreen extends StatefulWidget {
  final int userStoryId;
  final int epicId;

  AddTaskScreen({required this.userStoryId, required this.epicId});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TaskDao _taskDao = TaskDao(); // Create a TaskDao instance

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        name: _nameController.text,
        description: _descriptionController.text,
        status: Status.todo,
        EpicId: widget.epicId,
        UserStoryId: widget.userStoryId,
        priority: 0,
      );

      try {
        // Insert the task into the database
        int taskId = await _taskDao.insert(task);
        // If the insertion is successful, pop the screen with the new task's ID
        Navigator.pop(context, taskId);
      } catch (e) {
        // Handle database insertion errors
        print('Error inserting task: $e');
        // You might want to show an error message to the user here
        Navigator.pop(context, null); // Pop with null to indicate an error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
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