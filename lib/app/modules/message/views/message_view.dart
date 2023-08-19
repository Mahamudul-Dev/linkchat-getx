import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/modules/message/views/chat_input_field.dart';
import 'package:linkchat/app/modules/message/views/text_message.dart';
import 'package:linkchat/app/style/app_color.dart';

import '../../links/controllers/linklist_controller.dart';
import '../controllers/message_controller.dart';

class MessageView extends StatefulWidget {
  MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final String sId = Get.arguments['sId'];

  final ChatController _chatController = Get.find<ChatController>();

  final controller = Get.find<MessageController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.getMessage(DatabaseHelper().getSingleConversation(sId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildHeaderBar(_chatController, sId, context),
      body: Column(
        children: [
          Obx(() => controller.messages.value.isNotEmpty ? Expanded(
              child: Obx(() => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.messages.value.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return TextMessage(message: controller.messages.value[index]);
                  }))) : const Expanded(child: Center(child: Text('No Chat'),))),
          ChatInputField(receiverId: sId,)
        ],
      ),
    );
  }
}

AppBar _buildHeaderBar(
    ChatController chatController, String sId, BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        _circularAvatar(
            chatController.linikedList
                .singleWhere((element) => element.sId == sId)
                .profilePic,
            chatController.linikedList
                .singleWhere((element) => element.sId == sId)
                .isActive),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatController.linikedList
                  .singleWhere((element) => element.sId == sId)
                  .userName,
              style: Theme.of(context).textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              chatController.linikedList
                      .singleWhere((element) => element.sId == sId)
                      .isActive
                  ? 'Online'
                  : 'Not Available',
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ],
    ),
    actions: [
      IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.phone, color: accentColor,)),
      IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.video_camera, color: accentColor, size: 30,))
    ],
  );
}

Widget _circularAvatar(String profilePic, bool isActive) {
  return Stack(
    children: [
      CircleAvatar(
          radius: 20.h,
          backgroundColor: darkAsh,
          backgroundImage: CachedNetworkImageProvider(profilePic)),
      isActive
          ? Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                width: 13,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            )
          : const SizedBox.shrink()
    ],
  );
}
