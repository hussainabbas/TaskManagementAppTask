import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({required String id, required String title})
      : super(id: id, title: title);

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(id: task.id, title: task.title);
  }

  Task toEntity() {
    return Task(id: id, title: title);
  }
}
