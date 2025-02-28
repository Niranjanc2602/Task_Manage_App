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


}