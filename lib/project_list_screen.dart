import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_rgr/project.dart'; // Модель проекта

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  List<Project> projects = []; // Список проектов

  Future<void> _loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getString('userId'); // Получаем ID текущего пользователя

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    // Для демонстрации добавляем фиктивные проекты, принадлежащие пользователю
    setState(() {
      projects = [
        Project(
            id: '1',
            title: 'Проект 1',
            description: 'Описание проекта 1',
            userId: userId),
        Project(
            id: '2',
            title: 'Проект 2',
            description: 'Описание проекта 2',
            userId: userId),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои проекты')),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].title),
            subtitle: Text(projects[index].description),
          );
        },
      ),
    );
  }
}
