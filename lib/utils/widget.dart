import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite_test/models/Epic.dart';
import 'package:sqflite_test/models/Task.dart';
import 'package:sqflite_test/models/UserStory.dart';
import 'package:sqflite_test/models/WorkItemData.dart';
import 'package:sqflite_test/screens/epic_detail_screen.dart';
import 'package:sqflite_test/screens/task_detail_screen.dart';
import 'package:sqflite_test/screens/user_story_detail_screen.dart';

Widget ListDisplayWidget(BuildContext context, List<WorkItemData> workItemDataList, Function(void Function()) setState){
  return Container(
    width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height / 1.5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        workItemDataList.isEmpty
            ? Center(child: Text('No user stories found.'))
            : Expanded(
          child: ListView.builder(
            itemCount: workItemDataList.length,
            itemBuilder: (context, index) {
              final workItem = workItemDataList[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(workItem.name),
                  subtitle: Text(workItem.description),
                  onTap: () {
                    if (workItem.type == "EPIC"){
                      Epic? epic = workItem.toEpic();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  EpicDetailScreen(epic: epic)
                        )
                      ).then ((updatedEpic) {
                        if (updatedEpic != null && updatedEpic is Epic) {
                          final updatedItemDate = updatedEpic.toWorkItemData();
                          setState(() {
                            workItemDataList[index] = updatedItemDate;
                          });

                        }
                      });
                    }
                    else if (workItem.type == "USER STORY"){
                      UserStory? userStory = workItem.toUserStory();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  UserStoryDetailScreen(userStory: userStory)));
                    } else{
                      Task? task = workItem.toTask();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  TaskDetailScreen(task: task)));
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}