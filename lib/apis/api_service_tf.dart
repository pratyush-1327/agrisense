import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class ApiService {
  static const String baseUrl = 'https://agrisense-backend.onrender.com';

  static Future<Map<String, dynamic>> predictDisease(File imageFile) async {
    final client = RetryClient(http.Client());
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/predict'),
      );

      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await client.send(request);

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);
        return {
          'class': decodedResponse['class'],
          'confidence': decodedResponse['confidence'],
        };
      } else {
        final responseBody = await response.stream.bytesToString();
        print(
            'Error: Status code ${response.statusCode}, response body: $responseBody');
        throw Exception('Failed to get prediction');
      }
    } finally {
      client.close();
    }
  }
}
