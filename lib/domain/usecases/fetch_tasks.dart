import '../entities/task.dart';
import '../repositories/task_repository.dart';

class FetchTasks {
  final TaskRepository repository;

  FetchTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.fetchTasks();
  }
}
