import 'package:flutter/material.dart';
import 'package:sqflite_test/models/Task.dart';
import '../utils/dummy_data.dart';
import 'package:sqflite_test/screens/task_detail_screen.dart';


class TaskListScreen extends StatefulWidget {
  final int userStoryId;

  TaskListScreen({required this.userStoryId});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tasks = DummyData.getDummyTasks(widget.userStoryId);
  }

  void _addTask(Task task) {
    setState(() {
      _tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _tasks.isEmpty
          ? Center(child: Text('No tasks found.'))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(task.name),
              subtitle: Text(task.description!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}