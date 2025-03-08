import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/dao/Task_dao.dart';
import 'package:sqflite_test/dao/UserStory_dao.dart';
import 'package:sqflite_test/models/Task.dart';
import 'package:sqflite_test/models/UserStory.dart';
import 'package:sqflite_test/models/WorkItemData.dart';
import 'package:sqflite_test/screens/add_note_screen.dart';
import 'package:sqflite_test/screens/add_task_screen.dart';
import 'package:sqflite_test/screens/view_notes_screen.dart';
import '../utils/widget.dart';

class UserStoryDetailScreen extends StatefulWidget {
  final UserStory userStory;

  const UserStoryDetailScreen({super.key, required this.userStory});

  @override
  State<UserStoryDetailScreen> createState() => _UserStoryDetailScreenState();
}

class _UserStoryDetailScreenState extends State<UserStoryDetailScreen> {
  late UserStory userStory;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priorityController;
  late Status _selectedStatus;
  List<Task> _tasks = [];
  List<WorkItemData> _workItemData = [];
  Status? _selectedSortStatus;
  final TaskDao _taskDao = TaskDao();
  final UserStoryDao _userStoryDao = UserStoryDao();

  @override
  void initState() {
    super.initState();
    userStory = widget.userStory;
    _loadTasks();
    _nameController = TextEditingController(text: userStory.name);
    _descriptionController = TextEditingController(text: userStory.description);
    _priorityController =
        TextEditingController(text: userStory.priority.toString());
    _selectedStatus = userStory.status;
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await _taskDao.getTasksByUserStoryId(userStory.Id!);
    setState(() {
      _tasks = tasks;
      _workItemData = tasks.map((task) => task.toWorkItemData()).toList();
    });
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
      final updatedUserStory = UserStory(
        Id: userStory.Id,
        name: _nameController.text,
        description: _descriptionController.text,
        status: _selectedStatus,
        priority: int.tryParse(_priorityController.text) ?? 0,
        EpiId: userStory.EpiId,
      );
      try {
        await _userStoryDao.update(updatedUserStory);
        Navigator.pop(context, updatedUserStory);
      } catch (e) {
        print('Error updating user story: $e');
        Navigator.pop(context, null);
      }
    }
  }

  void _sortTasksByStatus(Status? status) {
    setState(() {
      _selectedSortStatus = status;
      if (status == null) {
        // Show all items
        _workItemData = _tasks.map((task) => task.toWorkItemData()).toList();
      } else {
        // Filter items based on the selected status
        _workItemData = _tasks
            .where((task) => task.status == status)
            .map((task) => task.toWorkItemData())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Story Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery
                .sizeOf(context)
                .width,
            height: MediaQuery
                .sizeOf(context)
                .height,
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
                  Text('Due Date: ${userStory.dateTime}'),
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
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddTaskScreen(
                                              epicId: userStory.EpiId,
                                              userStoryId: userStory.Id!,
                                            )),
                                  ).then((result) {
                                    if (result != null && result is int) {
                                      int newTaskId = result;
                                      print('New task added with ID: $newTaskId');
                                      _loadTasks();
                                    } else {
                                      print('Error adding task');
                                    }
                                  });
                                },
                                child: Text("Create Task")),
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
                                                epicId: userStory.EpiId, userStoryId: userStory.Id!)),
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
                                                epicId: userStory.Id!)),
                                  );
                                },
                                child: Text("View Notes"))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<Status?>(
                    value: _selectedSortStatus,
                    hint: Text('Sort by Status'),
                    onChanged: (Status? newValue) {
                      _sortTasksByStatus(newValue);
                    },
                    items: [
                      DropdownMenuItem<Status?>(
                        value: null,
                        child: Text('All'),
                      ),
                      ...Status.values
                          .map<DropdownMenuItem<Status>>((Status value) {
                        return DropdownMenuItem<Status>(
                          value: value,
                          child: Text(value
                              .toString()
                              .split('.')
                              .last),
                        );
                      }).toList(),
                    ],
                  ),
                  Expanded(
                      child: ListDisplayWidget(
                          context, _workItemData, setState)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}