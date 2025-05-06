import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// Only imported on Web:
import 'dart:html' as html;

class ApiService {
  late final String baseUrl;

  ApiService() {
    if (kIsWeb) {
      // On Web use the host the page was served from (ignores dev port)
      final host = html.window.location.hostname;
      baseUrl = 'http://$host/habitra_api/api';
    } else {
      // Android emulator → 10.0.2.2, iOS & desktop → localhost
      final host = defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2'
          : '127.0.0.1';
      baseUrl = 'http://$host/habitra_api/api';
    }
  }

  void _ensureSuccess(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      final jsonBody = res.body.isNotEmpty ? jsonDecode(res.body) : {};
      throw Exception(jsonBody['error'] ?? 'HTTP ${res.statusCode}');
    }
  }

  Future<Map<String, dynamic>> get(String fileName) async {
    final uri = Uri.parse('$baseUrl/$fileName');
    final res = await http.get(uri);
    _ensureSuccess(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(
      String fileName, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/$fileName');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    _ensureSuccess(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(
          String fileName, Map<String, dynamic> body) =>
      post(fileName, body);

  Future<Map<String, dynamic>> delete(String fileName) async {
    final uri = Uri.parse('$baseUrl/$fileName');
    final res = await http.delete(uri);
    _ensureSuccess(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}