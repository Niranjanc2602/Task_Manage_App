import 'package:sqflite_test/constants/Status.dart';

import 'package:sqflite_test/models/Epic.dart';
import '../models/UserStory.dart';
import 'package:sqflite_test/models/Task.dart';

class DummyData {
  static List<Epic> getDummyEpics() {
    return [
      Epic(id: 1, name: 'Epic 1', description: 'Description for Epic 1', status: Status.todo, priority: 0),
      Epic(id: 2, name: 'Epic 2', description: 'Description for Epic 2', status: Status.inProgress, priority: 0),
      Epic(id: 3, name: 'Epic 3', description: 'Description for Epic 3', status: Status.done, priority: 0),
      Epic(id: 4, name: 'Epic 4', description: 'Description for Epic 4', status: Status.todo, priority: 0),
      Epic(id: 5, name: 'Epic 5', description: 'Description for Epic 5', status: Status.inProgress, priority: 0),
    ];
  }

  static List<UserStory> getDummyUserStories(int epicId) {
    switch (epicId) {
      case 1:
        return [
          UserStory(Id: 1, EpiId: 1, name: 'User Story 1.1', description: 'Description for User Story 1.1', status: Status.todo, priority: 0),
          UserStory(Id: 2, EpiId: 1, name: 'User Story 1.2', description: 'Description for User Story 1.2', status: Status.inProgress, priority: 0),
          UserStory(Id: 3, EpiId: 1, name: 'User Story 1.3', description: 'Description for User Story 1.3', status: Status.done, priority: 0),
        ];
      case 2:
        return [
          UserStory(Id: 4, EpiId: 2, name: 'User Story 2.1', description: 'Description for User Story 2.1', status: Status.todo, priority: 0),
          UserStory(Id: 5, EpiId: 2, name: 'User Story 2.2', description: 'Description for User Story 2.2', status: Status.inProgress, priority: 0),
        ];
      case 3:
        return [
          UserStory(Id: 6, EpiId: 3, name: 'User Story 3.1', description: 'Description for User Story 3.1', status: Status.done, priority: 0),
        ];
      case 4:
        return [
          UserStory(Id: 7, EpiId: 4, name: 'User Story 4.1', description: 'Description for User Story 4.1', status: Status.todo, priority: 0),
          UserStory(Id: 8, EpiId: 4, name: 'User Story 4.2', description: 'Description for User Story 4.2', status: Status.inProgress, priority: 0),
          UserStory(Id: 9, EpiId: 4, name: 'User Story 4.3', description: 'Description for User Story 4.3', status: Status.done, priority: 0),
        ];
      case 5:
        return [
          UserStory(Id: 10, EpiId: 5, name: 'User Story 5.1', description: 'Description for User Story 5.1', status: Status.todo, priority: 0),
          UserStory(Id: 11, EpiId: 5, name: 'User Story 5.2', description: 'Description for User Story 5.2', status: Status.inProgress, priority: 0),
        ];
      default:
        return [];
    }
  }

  static List<Task> getDummyTasks(int userStoryId) {
    switch (userStoryId) {
      case 1:
        return [
          Task(Id: 1, UserStoryId: 1, name: 'Task 1.1.1', description: 'Description for Task 1.1.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 2, UserStoryId: 1, name: 'Task 1.1.2', description: 'Description for Task 1.1.2', status: Status.inProgress, EpicId: 0, priority: 0),
          Task(Id: 3, UserStoryId: 1, name: 'Task 1.1.3', description: 'Description for Task 1.1.3', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 2:
        return [
          Task(Id: 4, UserStoryId: 2, name: 'Task 1.2.1', description: 'Description for Task 1.2.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 5, UserStoryId: 2, name: 'Task 1.2.2', description: 'Description for Task 1.2.2', status: Status.inProgress, EpicId: 0, priority: 0),
        ];
      case 3:
        return [
          Task(Id: 6, UserStoryId: 3, name: 'Task 1.3.1', description: 'Description for Task 1.3.1', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 4:
        return [
          Task(Id: 7, UserStoryId: 4, name: 'Task 2.1.1', description: 'Description for Task 2.1.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 8, UserStoryId: 4, name: 'Task 2.1.2', description: 'Description for Task 2.1.2', status: Status.inProgress, EpicId: 0, priority: 0),
          Task(Id: 9, UserStoryId: 4, name: 'Task 2.1.3', description: 'Description for Task 2.1.3', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 5:
        return [
          Task(Id: 10, UserStoryId: 5, name: 'Task 2.2.1', description: 'Description for Task 2.2.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 11, UserStoryId: 5, name: 'Task 2.2.2', description: 'Description for Task 2.2.2', status: Status.inProgress, EpicId: 0, priority: 0),
        ];
      case 6:
        return [
          Task(Id: 12, UserStoryId: 6, name: 'Task 3.1.1', description: 'Description for Task 3.1.1', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 7:
        return [
          Task(Id: 13, UserStoryId: 7, name: 'Task 4.1.1', description: 'Description for Task 4.1.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 14, UserStoryId: 7, name: 'Task 4.1.2', description: 'Description for Task 4.1.2', status: Status.inProgress, EpicId: 0, priority: 0),
          Task(Id: 15, UserStoryId: 7, name: 'Task 4.1.3', description: 'Description for Task 4.1.3', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 8:
        return [
          Task(Id: 16, UserStoryId: 8, name: 'Task 4.2.1', description: 'Description for Task 4.2.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 17, UserStoryId: 8, name: 'Task 4.2.2', description: 'Description for Task 4.2.2', status: Status.inProgress, EpicId: 0, priority: 0),
        ];
      case 9:
        return [
          Task(Id: 18, UserStoryId: 9, name: 'Task 4.3.1', description: 'Description for Task 4.3.1', status: Status.done, EpicId: 0, priority: 0),
        ];
      case 10:
        return [
          Task(Id: 19, UserStoryId: 10, name: 'Task 5.1.1', description: 'Description for Task 5.1.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 20, UserStoryId: 10, name: 'Task 5.1.2', description: 'Description for Task 5.1.2', status: Status.inProgress, EpicId: 0, priority: 0),
        ];
      case 11:
        return [
          Task(Id: 21, UserStoryId: 11, name: 'Task 5.2.1', description: 'Description for Task 5.2.1', status: Status.todo, EpicId: 0, priority: 0),
          Task(Id: 22, UserStoryId: 11, name: 'Task 5.2.2', description: 'Description for Task 5.2.2', status: Status.inProgress, EpicId: 0, priority: 0),
        ];
      default:
        return [];
    }
  }
}