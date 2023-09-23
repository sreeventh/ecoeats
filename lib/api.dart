import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> generateChatCompletion(String message) async {
  const apiKey =
      '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'; // Replace with your actual API key
  const apiUrl = 'https://api.openai.com/v1/engines/davinci/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': message,
      'max_tokens': 256,
      'temperature': 1,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0 // Adjust max_tokens based on your requirements
    }),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('API Response: ${response.body}');
    throw Exception('Failed to load response');
  }
}
