import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/dao/Task_dao.dart';
import 'package:sqflite_test/models/Task.dart';
import 'package:sqflite_test/screens/add_note_screen.dart';
import 'package:sqflite_test/screens/view_notes_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task task;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priorityController;
  late Status _selectedStatus;
  Status? _selectedSortStatus;
  final TaskDao _taskDao = TaskDao();

  @override
  void initState() {
    super.initState();
    task = widget.task;
    _nameController = TextEditingController(text: task.name);
    _descriptionController = TextEditingController(text: task.description);
    _priorityController = TextEditingController(text: task.priority.toString());
    _selectedStatus = task.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _updateForm() async {
    if (_formKey.currentState!.validate()) {
      final updatedTask = Task(
        Id: task.Id,
        name: _nameController.text,
        description: _descriptionController.text,
        status: _selectedStatus,
        priority: int.tryParse(_priorityController.text) ?? 0,
        UserStoryId: task.UserStoryId,
        dateTime: task.dateTime,
        EpicId: task.EpicId,
      );
      try {
        await _taskDao.update(updatedTask);
        Navigator.pop(context, updatedTask);
      } catch (e) {
        print('Error updating task: $e');
        Navigator.pop(context, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 10),
                DropdownButtonFormField<Status>(
                  value: _selectedStatus,
                  onChanged: (Status? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                  items: Status.values
                      .map<DropdownMenuItem<Status>>((Status value) {
                    return DropdownMenuItem<Status>(
                      value: value,
                      child: Text(value
                          .toString()
                          .split('.')
                          .last),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                Text('Due Date: ${task.dateTime}'),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery
                      .sizeOf(context)
                      .width / 1.5,
                  constraints: BoxConstraints(
                      minHeight: MediaQuery
                          .sizeOf(context)
                          .height / 9),
                  color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: _updateForm,
                              child: Text("Update")),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddNoteScreen(
                                              epicId: task.EpicId ,  userStoryId: task.UserStoryId ,taskId: task.Id!)),
                                );
                              },
                              child: Text("Add Note")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewNotesScreen(
                                              epicId: task.EpicId,  userStoryId: task.UserStoryId ,taskId: task.Id!)),
                                );
                              },
                              child: Text("View Notes"))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}