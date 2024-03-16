import 'dart:convert';

import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/utils/enums/gpt_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OpenAiApi {
  static Future<Map<String, dynamic>> _apiCall(GPTmodel model, String prompt) async {
    const maxTokens = 50;
    const temperatures = 0.8;
    const uri = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['token']}',
    };
    final requestBody = {
      'model': model.toStr,
      'prompt': prompt,
      'max_tokens': maxTokens,
      'temperature': temperatures,
    };

    final response = await http.post(Uri.parse(uri), headers: headers, body: requestBody);
    if(response.statusCode != 200) {
      "Open Ai Api\nStatus Code : ${response.statusCode}\nMessage : ${jsonDecode(response.body)['message']}".printError();
      return {};
    }
    return jsonDecode(response.body);
  }

  static Future<ChatResponse> getResponse(GPTmodel model, String prompt) async {
    final result = await _apiCall(model, prompt);
    return ChatResponse.fromJson(result);
  }
}