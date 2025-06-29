import 'dart:convert';
import 'package:http/http.dart' as http;
import 'message_model.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000";  // Адрес твоего сервера

  // Метод для отправки сообщения на сервер
  Future<Message?> sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send_message'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': text,
        }),
      );

      if (response.statusCode == 201) {
        // Если запрос успешный, возвращаем полученное сообщение
        return Message.fromJson(jsonDecode(response.body));
      } else {
        print('Ошибка: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Ошибка: $e');
      return null;
    }
  }

  // Метод для получения всех сообщений с сервера
  Future<List<Message>?> getMessages() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/messages'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((message) => Message.fromJson(message)).toList();
      } else {
        print('Ошибка: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Ошибка: $e');
      return null;
    }
  }
}
