import 'package:sqflite_test/constants/Status.dart';
import '../models/WorkItemData.dart';

class UserStory{

  int? Id;
  String name;
  String? description;
  int EpiId;
  int? dependEpicId;
  int? dependUserStoryId;
  // Tasks? dependTask;
  DateTime? dateTime;
  Status status;
  int? priority;

  UserStory({ this.Id, required this.name, this.description, required this.EpiId, this.dependEpicId, this.dependUserStoryId, this.dateTime, required this.status, this.priority}){}

  WorkItemData toWorkItemData() {
    return WorkItemData(
      id: this.Id!,
      name: this.name,
      description: this.description!,
      status: this.status,
      EpicId: this.EpiId,type: "USER STORY");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': Id,
      'name': name,
      'description': description,
      'EpiId': EpiId,
      'datetime': dateTime?.toIso8601String(),
      'status': status.toString(),
      'priority': priority,
    };
  }

  static UserStory fromMap(Map<String, dynamic> map) {
    return UserStory(
      Id: map['id'],
      name: map['name'],
      description: map['description'],
      EpiId: map['EpiId'],
      dependEpicId: 0,
      dependUserStoryId: 0,
      dateTime: map['date_time'] != null
          ? DateTime.parse(map['date_time'])
          : null,
      status: Status.values.firstWhere((e) => e.toString() == map['status']),
      priority: map['priority'],
    );
  }

}