
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/models/WorkItemData.dart';

class Epic {
  final int? id;
  final String name;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final Status? status;
  final int? priority;

  Epic ({ this.id, required this.name, this.description, this.startDate, this.endDate, this.status = Status.todo, this.priority});

  WorkItemData toWorkItemData(){
    return WorkItemData(id: this.id!, name: this.name, description: this.description!, status: this.status!, EpicId: this.id!, type: "EPIC");
  }

}