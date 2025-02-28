import 'package:flutter/material.dart';
import 'package:sqflite_test/screens/add_task_screen.dart';
import 'package:sqflite_test/screens/task_list_screen.dart';
import '../models/UserStory.dart';

class UserStoryDetailScreen extends StatelessWidget {
  final UserStory userStory;

  UserStoryDetailScreen({required this.userStory});

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
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${userStory.name}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Status: ${userStory.status}'),
                SizedBox(height: 10),
                Text('Description: ${userStory.description}'),
                SizedBox(height: 10), // Add some spacing
                Text('Due Date: ${userStory.dateTime}'),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.sizeOf(context).width/1.5,
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height/9
                  ),
                  color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text("Update")),
                          ElevatedButton(onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddTaskScreen(userStoryId: userStory.Id!,)),
                            );
                          }, child: Text("Create Task")),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text("Add Reason")),
                          ElevatedButton(onPressed: (){}, child: Text("View Reason"))
                        ],
                      ),
                    ],
                  ),),
                Expanded(child: TaskListScreen(userStoryId: userStory.Id!)),
                // Add more details here as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}