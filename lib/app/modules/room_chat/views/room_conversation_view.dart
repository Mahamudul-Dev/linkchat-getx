import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/app_color.dart';

import '../../../data/models/room_res_model.dart';
import '../controllers/room_conversation_controller.dart';
import 'room_chat_input_field.dart';

class RoomConversationView extends GetView<RoomConversationController> {
  RoomConversationView({super.key});

  final RoomModel roomModel = Get.arguments['room'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderBar(controller, roomModel, context),
      endDrawer: _buildDrawer(context, controller, roomModel),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: RoomConversationController.message.length,
                  itemBuilder: (context, index) {
                    return Obx(() => ListTile(
                          title:
                              Text(RoomConversationController.message[index]),
                        ));
                  }))),
          RoomChatInputField(roomId: roomModel.id),
        ],
      ),
    );
  }
}

AppBar _buildHeaderBar(RoomConversationController roomConversationController,
    RoomModel room, BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        const CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.groupName,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              _buildRoomMemberAvater(
                  roomConversationController: roomConversationController,
                  roomId: room.id,
                  context: context)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildRoomMemberAvater(
    {required RoomConversationController roomConversationController,
    required String roomId,
    required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.5,
    height: 30,
    child: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 5) {
                return CircleAvatar(
                  radius: 8,
                  backgroundColor: blackAccent,
                  child: Center(
                    child: Text(
                      '${index - 5}+',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                );
              } else {
                return const CircleAvatar(
                  radius: 8,
                  backgroundColor: blackAccent,
                  backgroundImage:
                      CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
                );
              }
            },
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 3),
            itemCount: 6)),
  );
}

Widget _buildDrawer(BuildContext context, RoomConversationController controller,
    RoomModel room) {
  return Align(
    alignment: Alignment.centerRight,
    child: Drawer(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: blackAccent,
            backgroundImage: CachedNetworkImageProvider(
                room.groupImage ?? PLACEHOLDER_IMAGE),
          )
        ],
      ),
    ),
  );
}
