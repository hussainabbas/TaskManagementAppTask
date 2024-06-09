import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/domain/entities/task.dart';
import 'package:task_manager/domain/repositories/task_repository.dart';
import 'package:task_manager/domain/usecases/add_task.dart';
import 'package:task_manager/domain/usecases/delete_task.dart';
import 'package:task_manager/domain/usecases/fetch_tasks.dart';

import 'task_repository_test.mocks.dart';


@GenerateMocks([TaskRepository])
void main() {
  group('FetchTasks UseCase', () {
    test('should return list of tasks', () async {
      final repository = MockTaskRepository();
      final usecase = FetchTasks(repository);

      when(repository.fetchTasks()).thenAnswer((_) async => [Task(id: '1', title: 'Test Task')]);

      final result = await usecase();

      expect(result, isA<List<Task>>());
      expect(result.length, 1);
      expect(result.first.title, 'Test Task');
    });
  });

  group('AddTask UseCase', () {
    test('should add a task', () async {
      final repository = MockTaskRepository();
      final usecase = AddTask(repository);
      final task = Task(id: '1', title: 'Test Task');

      await usecase(task);

      verify(repository.addTask(task)).called(1);
    });
  });

  group('DeleteTask UseCase', () {
    test('should delete a task', () async {
      final repository = MockTaskRepository();
      final usecase = DeleteTask(repository);
      const taskId = '1';

      await usecase(taskId);

      verify(repository.deleteTask(taskId)).called(1);
    });
  });
}
