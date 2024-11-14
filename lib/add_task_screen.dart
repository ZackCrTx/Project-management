import 'package:flutter/material.dart';
import 'package:flutter_application_rgr/task.dart'; // Модель задачи
import 'package:flutter_application_rgr/project.dart'; // Модель проекта

class AddTaskScreen extends StatelessWidget {
  final Project project;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddTaskScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить задачу')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название задачи'),
            ),
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(labelText: 'Статус задачи'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание задачи'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  projectId: project.id,
                  title: _titleController.text,
                  status: _statusController.text,
                  description: _descriptionController.text,
                );
                Navigator.pop(context, newTask); // Возвращаем задачу на экран
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
