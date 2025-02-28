import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/models/UserStory.dart';
import 'package:sqflite_test/models/WorkItemData.dart';
import 'package:sqflite_test/screens/add_note_screen.dart';
import 'package:sqflite_test/screens/add_user_story_screen.dart';
import 'package:sqflite_test/screens/view_notes_screen.dart';
import 'package:sqflite_test/utils/dummy_data.dart';
import 'package:sqflite_test/models/Epic.dart';
import '../utils/widget.dart';

class EpicDetailScreen extends StatefulWidget {
  final Epic epic;

  const EpicDetailScreen({super.key, required this.epic});

  @override
  State<EpicDetailScreen> createState() => _EpicDetailScreenState();
}

class _EpicDetailScreenState extends State<EpicDetailScreen> {
  late Epic epic;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priorityController;
  late Status _selectedStatus;
  List<UserStory> _userStories = [];
  List<WorkItemData> _workItemData = [];
  Status? _selectedSortStatus;

  @override
  void initState() {
    super.initState();
    epic = widget.epic;
    _userStories = DummyData.getDummyUserStories(epic.id!);
    _workItemData = _userStories.map((userStory) => userStory.toWorkItemData()).toList();
    _nameController = TextEditingController(text: epic.name);
    _descriptionController = TextEditingController(text: epic.description);
    _priorityController = TextEditingController(text: epic.priority.toString());
    _selectedStatus = epic.status!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _updateForm() {
    if (_formKey.currentState!.validate()) {
      final updatedEpic = Epic(
        id: epic.id,
        name: _nameController.text,
        description: _descriptionController.text,
        status: _selectedStatus,
        priority: 0,
      );
      Navigator.pop(context, updatedEpic);
    }
  }

  void _sortUserStoriesByStatus(Status? status) {
    setState(() {
      _selectedSortStatus = status;
      if (status == null) {
        // Show all items
        _workItemData = _userStories.map((userStory) => userStory.toWorkItemData()).toList();
      } else {
        // Filter items based on the selected status
        _workItemData = _userStories
            .where((userStory) => userStory.status == status)
            .map((userStory) => userStory.toWorkItemData())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Epic Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
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
                    items: Status.values.map<DropdownMenuItem<Status>>((Status value) {
                      return DropdownMenuItem<Status>(
                        value: value,
                        child: Text(value.toString().split('.').last),
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
                  Text('Due Date: ${epic.endDate}'),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 1.5,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.sizeOf(context).height / 9),
                    color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: _updateForm, child: Text("Update")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddUserStoryScreen(
                                                epicId: epic.id!)),
                                  );
                                },
                                child: Text("Create User Story")),
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
                                                  epicId: epic.id!)),
                                    );

                                }, child: Text("Add Note")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewNotesScreen(
                                                epicId: epic.id!)),
                                  );
                                }, child: Text("View Reason"))
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
                      _sortUserStoriesByStatus(newValue);
                    },
                    items: [
                      DropdownMenuItem<Status?>(
                        value: null,
                        child: Text('All'),
                      ),
                      ...Status.values.map<DropdownMenuItem<Status>>((Status value) {
                        return DropdownMenuItem<Status>(
                          value: value,
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
                    ],
                  ),
                  Expanded(
                    child: ListDisplayWidget(context, _workItemData, setState)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}