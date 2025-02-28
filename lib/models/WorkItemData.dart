import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/models/Epic.dart';
import 'package:sqflite_test/models/Task.dart';
import 'package:sqflite_test/models/UserStory.dart';


class WorkItemData {
  int id;
  String name;
  String description;
  Status status;
  int EpicId;
  int? UserStoryId;
  int? priority;
  DateTime? startDate;
  DateTime? endDate;
  String? type; // Add a type to identify the original class

  WorkItemData({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.EpicId,
    this.UserStoryId,
    this.priority,
    this.startDate,
    this.endDate,
    this.type,
  });

  Epic toEpic(){
    return Epic(id: this.id, name: this.name, description: this.description, status: this.status, priority: 0);
  }

  UserStory toUserStory(){
    return UserStory(Id: this.id, name: this.name, description: this.description, EpiId: this.EpicId, status: this.status, priority: this.priority);
  }

  Task toTask(){
    return Task(Id: this.id, name: this.name, description: this.description, EpicId: this.EpicId, UserStoryId: this.UserStoryId!, status: this.status, priority: this.priority!);
  }
}