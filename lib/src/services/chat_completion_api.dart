import 'dart:convert';

import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/src/services/api_urls.dart';
import 'package:chit_chat_pro/utils/enums/gpt_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatCompletionApi {
  static Future<Map<String, dynamic>> _apiCall(String prompt, GPTmodel? model) async {
    const maxTokens = 50;
    const temperatures = 0.8;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['token']}',
    };
    final requestBody = jsonEncode({
      'model': GPTmodel.turbo.toStr, // TODO : Dynamic model
      'messages': [{"role": "user", "content": "Linear search in c++"}],
      'max_tokens': maxTokens,
      'temperature': temperatures,
    });

    final response = await http.post(Uri.parse(chatUrl), headers: headers, body: requestBody);
    if(response.statusCode != 200) {
      "Open Ai Api\nStatus Code : ${response.statusCode}\nMessage : ${jsonDecode(response.body)['Message']['error']['message']}".printError();
      return {};
    }
    return jsonDecode(response.body);
  }

  static Future<ChatResponse> getChat(String prompt, {GPTmodel? model}) async {
    final result = await _apiCall(prompt, model);
    jsonEncode(result).toString().printInfo();
    return ChatResponse.fromJson(result);
  }
}