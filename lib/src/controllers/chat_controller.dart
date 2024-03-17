import 'package:chit_chat_pro/src/model/choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final isMainChat = true.obs;
  TextEditingController textController = TextEditingController();
  final chat = <Choice>[].obs;

  final jsonList = [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Linear search is a simple searching algorithm that sequentially checks each element in a list until a match is found or the whole list has been searched. Here is an implementation of linear search in C++:\n\n```cpp\n#include <iostream>\nusing namespace std;\n\n"
      },
      "logprobs": null,
      "finish_reason": "length"
    },
  ];

  @override
  void onInit() {
    super.onInit();
    chat.add(Choice.fromJson(jsonList.first));
  }
}
