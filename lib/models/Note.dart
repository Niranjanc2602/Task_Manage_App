class Note {
  int? id;
  int epicId;
  int? userStoryId;
  int? taskId;
  String description;
  DateTime? dateTime;

  Note({this.id, required this.epicId, required this.description, this.userStoryId, this.taskId, this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'dateTime': dateTime?.toIso8601String(),
      'epicId': epicId,
      'userStoryId': userStoryId,
      'taskId': taskId,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      description: map['description'],
      dateTime: map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
      epicId: map['epicId'],
      userStoryId: map['userStoryId'],
      taskId: map['taskId'],
    );
  }
}