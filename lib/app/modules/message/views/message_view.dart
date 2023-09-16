import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:chatview/chatview.dart' as chatview;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import '../controllers/message_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final String sId = Get.arguments['sId'];

  final ChatController _chatController = Get.find<ChatController>();

  final controller = Get.find<MessageController>();

  late chatview.ChatController chatViewController;

  @override
  void initState() {
    controller.getMessage(P2PChatHelper.getSingleConversation(sId), sId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: _buildHeaderBar(_chatController, sId, context),
        body: Obx(() => MessageController.chatViewController.value != null
            ? chatview.ChatView(
                onSendTap: (message, replyMessage, messageType) {
                  controller.onSendTap(message, replyMessage, messageType, sId);
                  Logger().i(message);
                  Logger().i(messageType);
                },
                showTypingIndicator: false,
                chatController: MessageController.chatViewController.value!,
                currentUser: chatview.ChatUser(
                  id: AccountHelper.getUserData().serverId,
                  name: AccountHelper.getUserData().name,
                  profilePhoto: AccountHelper.getUserData().photo,
                ),
                chatViewState: chatview.ChatViewState.hasMessages,
                typeIndicatorConfig: const chatview.TypeIndicatorConfiguration(
                    flashingCircleDarkColor: accentColor,
                    flashingCircleBrightColor: white),
                appBar: _buildHeaderBar(_chatController, sId, context),
                chatViewStateConfig: chatview.ChatViewStateConfiguration(
                  loadingWidgetConfig:
                      const chatview.ChatViewStateWidgetConfiguration(
                    loadingIndicatorColor: accentColor,
                  ),
                  onReloadButtonTap: () {},
                ),
                chatBackgroundConfig: chatview.ChatBackgroundConfiguration(
                    backgroundColor: black,
                    messageTimeTextStyle:
                        Theme.of(context).textTheme.bodyMedium),
                sendMessageConfig: const chatview.SendMessageConfiguration(
                  imagePickerConfiguration: chatview.ImagePickerConfiguration(),
                  defaultSendButtonColor: accentColor,
                  enableCameraImagePicker: false,
                  enableGalleryImagePicker: true,
                  textFieldBackgroundColor: blackAccent,
                  imagePickerIconsConfig:
                      chatview.ImagePickerIconsConfiguration(
                          galleryIconColor: accentColor,
                          galleryImagePickerIcon: Icon(
                            Icons.image_rounded,
                            color: white,
                          )),
                ),
                chatBubbleConfig: chatview.ChatBubbleConfiguration(
                    inComingChatBubbleConfig: chatview.ChatBubble(
                        color: blackAccent, onMessageRead: (message) {}),
                    outgoingChatBubbleConfig: chatview.ChatBubble(
                        color: accentColor, onMessageRead: (message) {})),
                reactionPopupConfig: const chatview.ReactionPopupConfiguration(
                    backgroundColor: blackAccent,
                    shadow: BoxShadow(color: black)),
                messageConfig: chatview.MessageConfiguration(
                  messageReactionConfig: chatview.MessageReactionConfiguration(
                    backgroundColor: blackAccent,
                    borderColor: Colors.transparent,
                    reactionsBottomSheetConfig:
                        chatview.ReactionsBottomSheetConfiguration(
                      backgroundColor: blackAccent,
                      reactedUserTextStyle: const TextStyle(
                        color: white,
                      ),
                      reactionWidgetDecoration: BoxDecoration(
                        color: blackAccent,
                        boxShadow: const [
                          BoxShadow(
                            color: black,
                            offset: Offset(0, 20),
                            blurRadius: 40,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  imageMessageConfig: chatview.ImageMessageConfiguration(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    shareIconConfig: chatview.ShareIconConfiguration(
                      defaultIconBackgroundColor: blackAccent,
                      defaultIconColor: white,
                    ),
                  ),
                ),
              )
            : Center(
                child: LoadingAnimationWidget.bouncingBall(
                    color: accentColor, size: 25),
              ))

        // Column(
        //   children: [
        //     Obx(() {
        //       if (MessageController.messages.isNotEmpty) {
        //         return Expanded(
        //             child: Obx(() => ListView.builder(
        //                   reverse: false,
        //                   controller: MessageController.scrollController,
        //                   physics: const BouncingScrollPhysics(),
        //                   itemCount: MessageController.messages.length,
        //                   padding: const EdgeInsets.symmetric(horizontal: 10),
        //                   itemBuilder: (context, index) {
        //                     return TextMessage(
        //                         message: MessageController.messages[index]);
        //                   },
        //                 )));
        //       } else {
        //         return const Expanded(child: Center(child: Text('No Chat')));
        //       }
        //     }),
        //     ChatInputField(receiverId: sId),
        //   ],
        // ),
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
      IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.phone,
            color: accentColor,
          )),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.video_camera,
            color: accentColor,
            size: 30,
          ))
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
