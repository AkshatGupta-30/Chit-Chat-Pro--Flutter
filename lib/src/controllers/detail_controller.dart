import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final int index;
  DetailController(this.index);
  
  final chatController = Get.find<ChatController>();
}