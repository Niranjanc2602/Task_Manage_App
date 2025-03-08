
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

  Map<String, dynamic> toMap() {
    return {
      'id': Id,
      'name': name,
      'description': description,
      'EpicId': EpicId,
      'UserStoryId': UserStoryId,
      'dateTime': dateTime?.toIso8601String(),
      'status': status.toString(),
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      Id: map['id'],
      name: map['name'],
      description: map['description'],
      EpicId: map['EpicId'],
      UserStoryId: map['UserStoryId'],
      dependEpicId: 0,
      dependUserStoryId: 0,
      dateTime: map['dateTime'] != null ? DateTime.parse(map['date_time']) : null,
      status: Status.values.firstWhere((e) => e.toString() == map['status']),
      priority: map['priority'] ?? 0,
    );
  }
}