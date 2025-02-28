class Note {
  int? id;
  int epicId;
  int? userStoryId;
  int? taskId;
  String description;
  DateTime? dateTime;

  Note({this.id, required this.epicId, required this.description, this.userStoryId, this.taskId, this.dateTime});
}