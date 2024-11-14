import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_rgr/project.dart'; // Модель проекта
import 'package:flutter_application_rgr/task.dart'; // Модель задачи
import 'package:flutter_application_rgr/add_task_screen.dart'; // Экран добавления задачи
import 'package:flutter_application_rgr/edit_task_screen.dart'; // Экран редактирования задачи

class TaskScreen extends StatefulWidget {
  final Project project;

  TaskScreen({required this.project});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    // Для демонстрации добавляем фиктивные задачи, привязанные к текущему проекту
    setState(() {
      tasks = [
        Task(
            id: '1',
            title: 'Задача 1',
            description: 'Описание задачи 1',
            projectId: widget.project.id,
            status: 'new'),
        Task(
            id: '2',
            title: 'Задача 2',
            description: 'Описание задачи 2',
            projectId: widget.project.id,
            status: 'new'),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Функция для добавления новой задачи
  void _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(project: widget.project),
      ),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask); // Добавляем новую задачу в список
      });
    }
  }

  // Функция для редактирования существующей задачи
  void _editTask(Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(
          task: task,
          onTaskUpdated: (updatedTask) {
            setState(() {
              // Обновляем задачу в списке
              final index = tasks.indexWhere((t) => t.id == updatedTask.id);
              if (index != -1) {
                tasks[index] = updatedTask;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Задачи проекта: ${widget.project.title}')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            onTap: () => _editTask(task), // Редактируем задачу по клику
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
        tooltip: 'Добавить задачу',
      ),
    );
  }
}
