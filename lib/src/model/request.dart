import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/utils/enums/gpt_model.dart';

class ChatRequest {
  GPTmodel? model;
  List<Message> messages;
  int? maxTokens;
  double? temperatures;
  ChatRequest({this.model, required this.messages, this.maxTokens, this.temperatures});

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(
      model: GPTmodel.fromStr(json['model']),
      messages: json['messages'],
      maxTokens: json['max_tokens'] ?? 50,
      temperatures: json['temperature'] ?? 0.7
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> messagesJson = messages.map((message) => message.toMap()).toList();

    return {
      'model': (model == null) ? GPTmodel.turbo.toStr : model!.toStr,
      'messages': messagesJson,
      'max_tokens': maxTokens ?? 50,
      'temperature': temperatures ?? 0.7,
    };
  }
}