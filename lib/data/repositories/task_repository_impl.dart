import 'package:uuid/uuid.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

final uuid = Uuid();

class TaskRepositoryImpl implements TaskRepository {
  final List<TaskModel> _tasks = [];

  @override
  Future<List<Task>> fetchTasks() async {
    return _tasks.map((taskModel) => taskModel.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(TaskModel(id: uuid.v4(), title: task.title));
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
  }
}