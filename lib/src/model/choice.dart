import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/utils/enums/finish_reason.dart';

class Choice {
  int index;
  Message message;
  dynamic logprobs;
  FinishReason finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    Message message = Message(role: json['message']['role'], content: json['message']['content']);

    return Choice(
      index: json['index'],
      message: message,
      logprobs: json['logprobs'],
      finishReason: FinishReason.fromStr(json['finish_reason']),
    );
  }
}