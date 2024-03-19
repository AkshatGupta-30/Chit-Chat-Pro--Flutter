import 'dart:async';

import 'package:chit_chat_pro/src/model/choice.dart';
import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/src/model/request.dart';
import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/src/services/chat_completion_api.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_string/super_string.dart';

class ChatController extends GetxController {
  RxInt countdown = 0.obs;
  RxBool isButtonEnabled = true.obs;
  Timer? timer;

  final isMainChat = true.obs;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  
  final _choices = <Choice>[].obs;
  final prompts = <Message>[].obs;
  final contents = <Message>[].obs;

  void startTimer() {
    countdown.value = 20;
    isButtonEnabled.value = false;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      countdown.value -= 1;
      if (countdown.value <= 0) {
        t.cancel();
        isButtonEnabled.value = true;
      }
    });
  }

  Future<void> submit() async {
    startTimer();
    prompts.add(Message(role: 'user', content: textController.text));
    textController.clear();

    ChatRequest chatRequest = ChatRequest(messages: prompts);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);

    _choices.addAll(chatResponse.choices);
    contents.add(_choices.last.message);
    update();
  }

  void deletePromptContentSection(int index) {
    prompts.removeAt(index);
    contents.removeAt(index);
  }

  void refreshChat() async {// TODO - Refresh chat and get new content at any index
    startTimer();
    // * - Refresh chat and get new content at last index
    _choices.removeLast();
    contents.removeLast();
    update();

    ChatRequest chatRequest = ChatRequest(messages: prompts);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);

    _choices.addAll(chatResponse.choices);
    contents.add(_choices.last.message);
  }

  Future<void> copy(int index) async {
    String msgToCpoy = '${prompts[index].role.title()}\n${prompts[index].content}\n\n${prompts[index].role.title()}\n${contents[index].content}';
    await FlutterClipboard.copy(msgToCpoy.replaceAll(r'\n', '\n'));
  }
}
