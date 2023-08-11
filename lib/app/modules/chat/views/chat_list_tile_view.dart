import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListTileView extends GetView<ChatController> {
  const ChatListTileView(
      {Key? key,
      required this.conversationName,
      this.profilePic,
      this.lastMessage,
      required this.time,
      this.unReadeCount,
      this.onTap})
      : super(key: key);
  final String conversationName;
  final String? profilePic;
  final String? lastMessage;
  final DateTime time;
  final int? unReadeCount;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        conversationName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
      subtitle: Text(lastMessage ?? ''),
      leading: CircleAvatar(
        backgroundImage:
            CachedNetworkImageProvider(profilePic ?? PLACEHOLDER_IMAGE),
      ),
      trailing: Text(
        timeago.format(time),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}
