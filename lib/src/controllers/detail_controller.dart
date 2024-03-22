import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/src/controllers/text_to_speech_controller.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final int index;
  DetailController(this.index) {
    tts = Get.put(TTSController(chatController.contents[index].content));
  }

  final chatController = Get.find<ChatController>();
  late final TTSController tts;

  @override
  void onClose() {
    tts.dispose();
    super.onClose();
  }
}