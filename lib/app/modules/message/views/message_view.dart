import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/widgets/widgets.dart';

import '../../links/controllers/linklist_controller.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  MessageView({Key? key}) : super(key: key);
  final String? _sId = Get.arguments['sId'];
  final LinklistController _linklistController = Get.find<LinklistController>();
  final ChatController _chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderBar(_chatController, _sId!, context),
      body: Container(),
    );
  }
}

AppBar _buildHeaderBar(
    ChatController chatController, String sId, BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        _circularAvatar(
            chatController.activeUser
                .singleWhere((element) => element.sId == sId)
                .profilePic,
            chatController.activeUser
                .singleWhere((element) => element.sId == sId)
                .isActive),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatController.activeUser
                  .singleWhere((element) => element.sId == sId)
                  .userName,
              style: Theme.of(context).textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              chatController.activeUser
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
    actions: const [
      RoundButtonView(icon: Icons.call_outlined, iconSize: 20),
      RoundButtonView(icon: CupertinoIcons.video_camera_solid, iconSize: 20)
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
