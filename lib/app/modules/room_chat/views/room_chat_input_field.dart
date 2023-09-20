import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../style/style.dart';
import '../controllers/room_conversation_controller.dart';

class RoomChatInputField extends GetView<RoomConversationController> {
  const RoomChatInputField({Key? key, required this.roomId}) : super(key: key);
  final String roomId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Obx(() => controller.textMessage.value.isEmpty
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic, color: accentColor))
                : const SizedBox.shrink()),
            Expanded(
                child: AnimatedContainer(
              duration: const Duration(milliseconds: 5000),
              decoration: BoxDecoration(
                  color: darkAsh, borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Obx(() {
                    return TextField(
                      controller: controller.textMessageController.value,
                      onChanged: (txt) {
                        controller.textMessage.value = txt;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type message...',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey)),
                    );
                  })),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file_rounded,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(
              width: 5.w,
            ),
            Obx(() => controller.textMessage.value.isNotEmpty
                ? IconButton(
                    onPressed: () => controller.sendMessage(roomId),
                    icon: const Icon(
                      Icons.send,
                      color: brightWhite,
                      size: 20,
                    ),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                  )
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
