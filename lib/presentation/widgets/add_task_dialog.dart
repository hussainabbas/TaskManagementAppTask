import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/task.dart';
import '../providers/task_providers.dart';

//Function to show a dialog for adding a new task
void showAddTaskDialog(BuildContext context, WidgetRef ref) {
  final taskController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(hintText: 'Task Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final taskTitle = taskController.text;
              if (taskTitle.isNotEmpty) {
                final task = Task(id: const Uuid().v4(), title: taskTitle);
                ref.read(taskListProvider.notifier).addTask(task);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
