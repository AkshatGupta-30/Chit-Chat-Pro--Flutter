import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/utils/sections/prompt_content_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';

class PromptView extends StatelessWidget {
  PromptView({super.key});
  
  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(() {
        if(controller.prompts.isEmpty) {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.emptyPrompts.length,
            itemBuilder: (context, index) {
              Map<String, String> question = controller.emptyPrompts[index];
              String title = question.keys.first;
              String subtitle = question.values.first;
              return GestureDetector(
                onTap: () => (controller.isButtonEnabled.value) ? controller.submit(prompt: '$title\n$subtitle') : null,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(subtitle),
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.prompts.length,
            itemBuilder: (context, index) {
              return PromptContentSection(index);
            },
          ),
          floatingActionButton: AnimatedSlide(
            offset: (controller.fabVisible.value) ? Offset.zero : const Offset(2,0),
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: (controller.fabVisible.value) ? 1 : 0,
              child: FloatingActionButton(
                onPressed: (controller.isScrollAbove.value) ? controller.scrollUp : controller.scrollDown,
                backgroundColor: Colors.cyanAccent, shape: const CircleBorder(),
                child: Iconify((controller.isScrollAbove.value) ? HeroiconsSolid.chevron_up : HeroiconsSolid.chevron_down, size: 40)
              ),
            ),
          ),
        );
      },
    ));
  }
}