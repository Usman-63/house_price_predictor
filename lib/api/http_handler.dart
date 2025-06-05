import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHandler {
  static const String _baseUrl = 'https://house-price-backend-unl1.onrender.com';

  static Future<Map<String, dynamic>> predict(Map<String, dynamic> inputData) async {
    final url = Uri.parse('$_baseUrl/predict');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inputData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to get prediction: ${response.statusCode} ${response.body}');
    }
  }
}