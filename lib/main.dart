import 'package:flutter/material.dart';
import 'package:flutter_application_rgr/register_screen.dart'; // Экран регистрации
import 'package:flutter_application_rgr/task_screen.dart'; // Экран задач
import 'package:flutter_application_rgr/screen.dart'; // Экран создания проекта
import 'package:flutter_application_rgr/login_screen.dart'; // Экран авторизации
import 'package:flutter_application_rgr/project.dart'; // Модель проекта

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Management App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      home: RegisterScreen(), // Заменено на экран регистрации
    );
  }
}

// ProjectScreen остался без изменений и будет доступен после входа
class ProjectScreen extends StatelessWidget {
  ElevatedButton _buildButton(
      BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, 'Перейти к регистрации', RegisterScreen()),
            const SizedBox(height: 10),
            // Передаем временный объект Project в TaskScreen
            _buildButton(
              context,
              'Перейти к задачам',
              TaskScreen(
                project: Project(
                  id: '1', // Пример ID проекта
                  title: 'Демо проект', // Пример названия
                  description: 'Описание проекта', // Пример описания
                  userId: '1', // Пример ID пользователя
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
