
import 'package:sqflite_test/constants/Status.dart';
import '../models/WorkItemData.dart';

class Task{

  int? Id;
  String name;
  String? description;
  int EpicId;
  int UserStoryId;
  int? dependEpicId;
  int? dependUserStoryId;
  DateTime? dateTime;
  Status status;
  final int priority;


  Task({this.Id, required this.name, this.description, required this.EpicId, required this.UserStoryId, this.dependEpicId, this.dependUserStoryId, this.dateTime, required this.status, required this.priority}){}

  WorkItemData toWorkItemData(){
    return WorkItemData(
      id: this.Id!,
      name: this.name,
      description: this.description!,
      status: this.status,
      EpicId: this.EpicId,
      UserStoryId: this.UserStoryId,
      type: "TASK"
    );
  }
}