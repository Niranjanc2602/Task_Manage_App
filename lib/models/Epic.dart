
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status?.toString().split('.').last,
      'priority': priority,
      'endDate': endDate?.toIso8601String(),
    };
  }

  // Convert a Map into a Epic.
  static Epic fromMap(Map<String, dynamic> map) {
    return Epic(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      status: Status.values.firstWhere(
              (e) => e.toString().split('.').last == map['status'],
          orElse: () => Status.todo),
      priority: map['priority'],
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
    );
  }

}