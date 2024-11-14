import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_rgr/task_screen.dart'; // Экран задач
import 'package:flutter_application_rgr/project.dart'; // Модель проекта

class Screen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Screen({Key? key}) : super(key: key);

  Future<void> _createProject(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getString('userId'); // Получаем ID текущего пользователя

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    final String title = _titleController.text;
    final String description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      // Создаем новый проект
      final newProject = Project(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        userId: userId,
      );

      // Сохраняем проект в SharedPreferences или базе данных
      // Для демонстрации мы просто выводим его в консоль
      print('Создан новый проект: ${newProject.title}, ID: ${newProject.id}');

      // Переходим на экран задач, передавая проект
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TaskScreen(project: newProject), // Передаем проект
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать проект')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название проекта'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание проекта'),
            ),
            ElevatedButton(
              onPressed: () => _createProject(context),
              child: const Text('Сохранить проект'),
            ),
          ],
        ),
      ),
    );
  }
}
