import 'package:flutter/material.dart';
import '../models/Task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${task.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Description: ${task.description}'),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}

