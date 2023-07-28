import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:linkchat/app/data/utils/utils.dart';

import '../../../modules/chat/controllers/chat_controller.dart';
import '../../../modules/message/views/chat_profile_bar_view.dart';
import '../../../modules/message/views/send_message_field_view.dart';
import '../../../style/style.dart';
import '../controllers/message_controller.dart';
import '../../followers/controllers/followers_controller.dart';

class MessageView extends GetView<MessageController> {
  MessageView({Key? key}) : super(key: key);
  final int uid = Get.arguments['uid'];
  final FollowersController followersController = Get.find<FollowersController>();
  final ChatController chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            ChatProfileBarView(
              name: 'Elon Musk',
              profilePic: PLACEHOLDER_IMAGE,
              tagLine: 'N/A',
              isActive: false,
              uid: uid,
            ),
            SliverList.separated(
              itemCount: (() {
                try {
                  return chatController.chatList
                      .singleWhere((element) => element.uid == uid)
                      .messages
                      ?.length;
                } catch (e) {
                  return 0;
                }
              })(),
              itemBuilder: (context, index) {
                // ignore: unrelated_type_equality_checks
                if (chatController.chatList.singleWhere((element) => element.uid == uid) ==
                    false) {
                  // Render the center widget for the first item when no element is found
                  return const Text('Say Hello...');
                } else {
                  return Row(
                    mainAxisAlignment: chatController.chatList
                            .singleWhere((element) => element.uid == uid)
                            .messages![index]
                            .isSent
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      ChatBubble(
                        clipper: ChatBubbleClipper1(
                            type: chatController.chatList
                                    .singleWhere(
                                        (element) => element.uid == uid)
                                    .messages![index]
                                    .isSent
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble),
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 20),
                        backGroundColor: chatController.chatList
                                .singleWhere((element) => element.uid == uid)
                                .messages![index]
                                .isSent
                            ? accentColor
                            : transparentBlack,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            chatController.chatList
                                .singleWhere((element) => element.uid == uid)
                                .messages![index]
                                .message,
                            style: const TextStyle(color: brightWhite),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 3);
              },
            )
          ],
        ),
        bottomNavigationBar: const SendMessageFieldView());
  }
}
