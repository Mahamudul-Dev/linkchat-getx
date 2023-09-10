import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_conversation_controller.dart';
import 'package:linkchat/app/modules/room_chat/views/room_chat_input_field.dart';
import 'package:linkchat/app/style/app_color.dart';

class RoomConversationView extends GetView<RoomConversationController> {
  const RoomConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderBar(controller, 'roomId', context),
      body: const Column(
        children: [
          Expanded(child: Center(child: Text('No Conversations'),)),
          RoomChatInputField(roomId: ''),
        ],
      ),
    );
  }
}


AppBar _buildHeaderBar(
    RoomConversationController roomConversationController, String roomId, BuildContext context) {
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
                'Linkfy Community',
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              _buildRoomMemberAvater(roomConversationController:roomConversationController, roomId: roomId, context: context)
            ],
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.podcasts_outlined,
          color: accentColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu_rounded,
          color: white,
          size: 30,
        ),
      )
    ],
  );

}

Widget _buildRoomMemberAvater({required RoomConversationController roomConversationController, required String roomId, required BuildContext context}) {
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
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                );
              } else {
                return const CircleAvatar(
                  radius: 8,
                  backgroundColor: blackAccent,
                  backgroundImage: CachedNetworkImageProvider(
                      PLACEHOLDER_IMAGE),
                );
              }
            },
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) =>
            const SizedBox(width: 3),
            itemCount: 6)
    ),
  );
}
