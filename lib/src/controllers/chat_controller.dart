import 'dart:async';

import 'package:chit_chat_pro/src/model/message.dart';
import 'package:chit_chat_pro/src/model/request.dart';
import 'package:chit_chat_pro/src/model/response.dart';
import 'package:chit_chat_pro/src/pages/detail_dialog.dart';
import 'package:chit_chat_pro/src/services/chat_completion_api.dart';
import 'package:chit_chat_pro/utils/enums/finish_reason.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:super_string/super_string.dart';

class ChatController extends GetxController {
  RxInt countdown = 0.obs;
  RxBool isButtonEnabled = true.obs;
  Timer? timer;

  final isMainChat = true.obs;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final fabVisible = false.obs;
  final isScrollAbove = false.obs;
  Timer? _hideTimer;
  final scrollController = ScrollController();

  final emptyPrompts = <Map<String, String>>[
    {"What is Flutter?" : "Definition and overview of the Flutter framework."},
    {"Programming Language in Flutter?" : "Clarification on the primary programming language used in Flutter."},
    {"Flutter vs. Other Frameworks?" : "A comparison between Flutter and other frameworks like React Native."},
    {"Flutter for Mobile Only?" : "Inquiry about the platforms supported by Flutter."},
    {"Accessing Native Features in Flutter?" : "How Flutter apps interact with native platform features."},
    {"State Management in Flutter?" : "Options and strategies for managing application state in Flutter."},
    {"Scalability of Flutter?" : "Discussion on Flutter's suitability for large-scale applications."},
    {"Flutter for Beginners?" : "Suitability of Flutter for newcomers to app development."},
    {"Cost of Using Flutter?" : "Explanation of Flutter's licensing and cost."},
  ].obs;

  final prompts = <Message>[].obs;
  final contents = <Message>[].obs;
  final finishReasons = <FinishReason>[].obs;
  final isAnimated = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.isScrollingNotifier.value) {
        fabVisible.value = true;
        if(scrollController.position.userScrollDirection == ScrollDirection.forward) {
          isScrollAbove.value = true;
        } else if(scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          isScrollAbove.value = false;
        }
        _hideTimer?.cancel();
        _hideTimer = Timer(Duration(seconds: 2), () => fabVisible.value = false);
      }
    });
  }

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

  void scrollUp() => scrollController.animateTo(0, duration: Duration(milliseconds: 250), curve: Curves.easeInOut,);

  void scrollDown() =>  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);

  Future<void> submit({String? prompt}) async {
    startTimer();
    if(prompt == null) {
      prompts.add(Message(role: 'user', content: textController.text));
      textController.clear();
    } else {
      prompts.add(Message(role: 'user', content: prompt));
    }

    ChatRequest chatRequest = ChatRequest(messages: prompts);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);
    contents.add(chatResponse.choices.first.message);
    isAnimated.add(false);
    finishReasons.add(chatResponse.choices.first.finishReason);
    update();
  }

  void deletePromptContentSection(int index) {
    prompts.removeAt(index);
    contents.removeAt(index);
    isAnimated.removeAt(index);
  }

  void refreshChat() async {// TODO - Refresh chat and get new content at any index
    startTimer();
    // * - Refresh chat and get new content at last index
    contents.removeLast();
    isAnimated.removeLast();
    update();

    ChatRequest chatRequest = ChatRequest(messages: prompts, maxTokens: 500);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);
    contents.add(chatResponse.choices.first.message);
    finishReasons.add(chatResponse.choices.first.finishReason);
    isAnimated.add(false);
    update();
  }

  Future<void> copy(int index) async {
    String msgToCpoy = '${prompts[index].role.title()}\n${prompts[index].content}\n\n${prompts[index].role.title()}\n${contents[index].content}';
    await FlutterClipboard.copy(msgToCpoy.replaceAll(r'\n', '\n'));
  }

  void showDetailDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(20)
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: DetailDialog(index))
        ),
      ),
    );
  }

  bool onNotification(UserScrollNotification notification) {
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.reverse) fabVisible.value = false;
    else if (direction == ScrollDirection.forward) fabVisible.value = true;
    return true;
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    timer!.cancel();
    super.onClose();
  }
}
