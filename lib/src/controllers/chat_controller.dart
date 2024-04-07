import 'dart:async';

import 'package:chit_chat_pro/src/controllers/image_to_text_controller.dart';
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
        _hideTimer = Timer(const Duration(seconds: 2), () => fabVisible.value = false);
      }
    });
  }

  void startTimer() {
    countdown.value = 20;
    isButtonEnabled.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      countdown.value -= 1;
      if (countdown.value <= 0) {
        t.cancel();
        isButtonEnabled.value = true;
      }
    });
  }

  void scrollUp() => scrollController.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut,);

  void scrollDown() =>  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);

  Future<void> submit({String? prompt}) async {
    startTimer();
    if(prompt == null) {
      final ittController = Get.find<ImageToTextController>();
      String contentOfPrompt = textController.text;
      if(ittController.imageFile.value.path.isNotEmpty) {
        contentOfPrompt = '${ittController.displayText.value}!!!!**!!!! $contentOfPrompt';
      }
      prompts.add(Message(role: 'user', content: contentOfPrompt, image: ittController.imageFile.value));
      ittController.removeImage();
      textController.clear();
    } else {
      prompts.add(Message(role: 'user', content: prompt));
    }

    ChatRequest chatRequest = ChatRequest(messages: prompts);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);
    contents.add(chatResponse.choices.first.message);
    isAnimated.add(false);
    finishReasons.add(chatResponse.choices.first.finishReason);
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

    ChatRequest chatRequest = ChatRequest(messages: prompts, maxTokens: 500);
    ChatResponse chatResponse = await ChatCompletionApi.getChat(chatRequest);
    contents.add(chatResponse.choices.first.message);
    finishReasons.add(chatResponse.choices.first.finishReason);
    isAnimated.add(false);
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
    if (direction == ScrollDirection.reverse) {
      fabVisible.value = false;
    } else if (direction == ScrollDirection.forward) {
      fabVisible.value = true;
    }
    return true;
  }

  List<InlineSpan> highlightCode(String text) {
    List<InlineSpan> spans = [];

    RegExp regExp = RegExp(r'```([^`]*)```');
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    int lastIndex = 0;
    for (RegExpMatch match in matches) {
      // * : Text other that code
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));

      String codeBlock = match.group(0)!;
      int firstNewlineIndex = codeBlock.indexOf('\n') + 1;
      spans.addAll([
        WidgetSpan(// * : Code Language
          child: Container(
            width: double.maxFinite, height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10))
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Text(
                    codeBlock.substring(0, firstNewlineIndex).replaceAll('```', '').title(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await FlutterClipboard.copy(codeBlock).then((value) => Get.rawSnackbar(title: 'Copied to Clipboard', messageText: const SizedBox()));
                  },
                  style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                  child: const Text('Copy', style: TextStyle(color: Colors.white70, fontSize: 14))
                )
              ],
            ),
          )
        ),
        WidgetSpan(// * : Actual Code
          child: Container(
            width: double.maxFinite, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            child: Text(
              codeBlock.substring(firstNewlineIndex).replaceAll('\n```', ''),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          )
        )
      ]);

      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return spans;
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    timer!.cancel();
    super.onClose();
  }
}
