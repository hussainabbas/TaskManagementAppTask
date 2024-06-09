import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

// Provider for the task repository
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl();
});

// StateNotifierProvider to manage the state of the task list
final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier(ref.watch(taskRepositoryProvider));
});

// StateNotifier class to handle the state of the task list
class TaskListNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  // Initializing with an empty list and loading tasks from the repository
  TaskListNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  // Function to load tasks from the repository
  Future<void> _loadTasks() async {
    state = await _repository.fetchTasks();
  }

  // Function to add a task to the repository and update the state
  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
    state = [...state, task]; // Update the state with the new task
  }

  // Function to delete a task from the repository and update the state
  Future<void> deleteTask(String taskId) async {
    await _repository.deleteTask(taskId);
    state = state
        .where((task) => task.id != taskId)
        .toList(); // Update the state by removing the task
  }
}
