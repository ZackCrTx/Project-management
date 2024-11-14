import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_rgr/main.dart'; // Убедитесь, что импортируете main.dart

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Строим приложение и запускаем фрейм
    await tester.pumpWidget(const MyApp());

    // Проверяем, что текст "0" есть, а текст "1" нет
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Нажимаем на кнопку "+"
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Проверяем, что счетчик увеличился
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
