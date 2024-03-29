import 'dart:convert';

import 'package:chit_chat_pro/src/model/request.dart';
import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/src/services/api_urls.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatCompletionApi {
  static Future<Map<String, dynamic>> _apiCall(ChatRequest chatRequest) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['token']}',
    };

    final response = await http.post(Uri.parse(chatUrl), headers: headers, body: jsonEncode(chatRequest.toMap()));
    if(response.statusCode != 200) {
      "Open Ai Api\nStatus Code : ${response.statusCode}\nMessage : ${jsonDecode(response.body)}".printError();
      return {};
    }
    return jsonDecode(response.body);
  }

  static Future<ChatResponse> getChat(ChatRequest chatRequest) async {
    final result = await _apiCall(chatRequest);
    return ChatResponse.fromJson(result);
  }
}