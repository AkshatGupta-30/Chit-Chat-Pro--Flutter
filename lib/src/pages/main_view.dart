import 'package:chit_chat_pro/src/controllers/chat_controller.dart';
import 'package:chit_chat_pro/utils/sections/prompt_content_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/heroicons_solid.dart';

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
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          floatingActionButton: GestureDetector(
            onTap: controller.autoScroll,
            child: CircleAvatar(backgroundColor: Colors.cyanAccent, child: Iconify(HeroiconsSolid.chevron_up_down, size: 35),
            )
          ),
        );
      },
    ));
  }
}