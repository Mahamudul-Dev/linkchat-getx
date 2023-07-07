import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListTileView extends GetView<ChatController> {
  const ChatListTileView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        controller.chatList[index].userName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Get.toNamed(Routes.MESSAGE,
            arguments: {'uid': Get.find<ChatController>().chatList[index].uid});
      },
      subtitle: Text(
          controller.chatList[index].messages?.last.message ??
              ''),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
            controller.chatList[index].profilePic ??
                controller.getPlaceHolder(
                    controller.chatList[index].gender)),
      ),
      trailing: Text(
        timeago.format(controller
            .chatList[index]
            .messages![index]
            .timeStamp),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
