import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/inspection_models.dart';

class ApiService {
  ApiService({required this.baseUrl});

  final String baseUrl;
  String? _token;

  Future<void> login({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 400 || payload['ok'] != true) {
      throw Exception(payload['message'] ?? 'No se pudo iniciar sesión');
    }

    _token = payload['token'] as String;
  }

  Future<void> createRecord({
    required InspectionHeader header,
    required List<InspectionEntry> entries,
  }) async {
    if (_token == null) throw Exception('Sesión no iniciada');

    final response = await http.post(
      Uri.parse('$baseUrl/records_create.php'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({
        'header': header.toJson(),
        'entries': entries.map((e) => e.toJson()).toList(),
      }),
    );

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 400 || payload['ok'] != true) {
      throw Exception(payload['message'] ?? 'Error al guardar registro');
    }
  }
}
