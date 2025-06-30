import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080'; // если Android эмулятор 10.0.2.2:8080

  static Future<String?> register(String login, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': login, 'password': password}),
    );
    return _handleResponse(response);
  }

  static Future<String?> login(String login, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': login, 'password': password}),
    );
    return _handleResponse(response);
  }

  static String? _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return null;
    } else {
      return response.body.isNotEmpty ? response.body : 'Ошибка сервера';
    }
  }
}
