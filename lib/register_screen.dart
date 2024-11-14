import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Убедитесь, что экран входа существует

class RegisterScreen extends StatelessWidget {
  // Контроллеры для текстовых полей
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  // Метод для регистрации пользователя
  Future<void> _registerUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Генерация уникального userId
    final userId = DateTime.now().millisecondsSinceEpoch.toString();

    // Сохраняем данные пользователя в SharedPreferences
    await prefs.setString('userId', userId);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);

    // Переход на экран входа после успешной регистрации
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true, // Прячем текст пароля
              decoration: const InputDecoration(labelText: 'Пароль'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _registerUser(context), // Вызов метода регистрации
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
