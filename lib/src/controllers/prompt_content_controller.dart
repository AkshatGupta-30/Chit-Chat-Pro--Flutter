import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/model/request.dart';
import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/src/services/chat_completion_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PCController extends GetxController {
  final int index;
  PCController(this.index);

  final isReEdit = false.obs;
  final chatController = Get.find<ChatController>();
  final promtTextController = TextEditingController();
  final focusNode = FocusNode();
  final _promptText = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _promptText.value = chatController.prompts[index].content;
    promtTextController.text = _promptText.value;
  }

  void editTapped() {
    if(isReEdit.value) {
      if(promtTextController.text.isNotEmpty) chatController.prompts[index].content = promtTextController.text;
      focusNode.unfocus();
      isReEdit.value = false;
    } else {
      promtTextController.text = _promptText.value;
      focusNode.requestFocus();
      isReEdit.value = true;
    }
    update();
  }

  Future<void> confirm() async {
    chatController.startTimer();
    editTapped();
    if(chatController.prompts.last != chatController.prompts[index]) {// TODO - Create a linked list for this instead of removing
      chatController.prompts.removeRange(index+1, chatController.prompts.length);
      chatController.contents.removeRange(index+1, chatController.contents.length);
    }
    update();

    ChatRequest chatRequest = ChatRequest(messages: chatController.prompts);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);
    chatController.contents.insert(index, chatResponse.choices.first.message);
    chatController.contents.removeAt(index+1);
    _promptText.value = promtTextController.text;
  }

  void cancel() {
    isReEdit.value = false;
    promtTextController.text = chatController.prompts[index].content;
  }
}