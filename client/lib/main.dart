import 'package:flutter/material.dart';
import 'registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чат-приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(), // Загружаем экран чата
    );
  }
}
