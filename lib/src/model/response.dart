import 'package:chit_chat_pro/src/model/choice.dart';
import 'package:chit_chat_pro/src/model/usage.dart';
import 'package:chit_chat_pro/utils/enums/gpt_model.dart';

class ChatResponse {
  String id;
  String object;
  DateTime created;
  GPTmodel model;
  String systemFingerprint;
  List<Choice> choices;
  Usage usage;

  ChatResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.systemFingerprint,
    required this.choices,
    required this.usage,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    List<Choice> choices = List<Choice>.from(json['choices'].map((choice) => Choice.fromJson(choice)));
    Usage usage = Usage.fromJson(json['usage']);

    return ChatResponse(
      id: json['id'],
      object: json['object'],
      created: DateTime.now(),
      model: GPTmodel.fromStr(json['model']),
      systemFingerprint: json['system_fingerprint'],
      choices: choices,
      usage: usage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'object': object,
      'created': created.toIso8601String(),
      'model': model.toStr,
      'system_fingerprint': systemFingerprint,
      'choices': choices.map((choice) => choice.toMap()).toList(),
      'usage': usage.toMap(),
    };
  }
}