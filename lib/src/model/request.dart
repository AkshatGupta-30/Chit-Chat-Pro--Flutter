import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/utils/enums/gpt_model.dart';

class ChatRequest {
  GPTmodel model;
  List<Message> messages;
  ChatRequest({required this.model, required this.messages});

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(model: GPTmodel.fromStr(json['model']), messages: json['messages']);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> messagesJson = messages.map((message) => message.toJson()).toList();

    return {
      'model': model.toStr,
      'messages': messagesJson,
    };
  }
}