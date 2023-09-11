import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/modules/message/views/chat_input_field.dart';
import 'package:linkchat/app/modules/message/views/text_message.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:chatview/chatview.dart' as chat;
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
    controller.getMessage(P2PChatHelper.getSingleConversation(sId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildHeaderBar(_chatController, sId, context),
      body: chat.ChatView(
        currentUser: controller.currentUser,
        chatController: controller.chatController,
        onSendTap: (msg, remsg, msgType) {},
        featureActiveConfig: const chat.FeatureActiveConfig(
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: true,
        ),
        chatViewState: controller.chatController.initialMessageList.isEmpty
            ? chat.ChatViewState.noData
            : chat.ChatViewState.hasMessages,
        chatViewStateConfig: chat.ChatViewStateConfiguration(
          loadingWidgetConfig: const chat.ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: accentColor,
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: const chat.TypeIndicatorConfiguration(
          flashingCircleBrightColor: accentColor,
          flashingCircleDarkColor: white,
        ),
        appBar: chat.ChatViewAppBar(
          elevation: 0,
          backGroundColor: black,
          profilePicture: _chatController.linikedList
              .singleWhere((element) => element.sId == sId)
              .profilePic,
          backArrowColor: white,
          chatTitle: _chatController.linikedList
              .singleWhere((element) => element.sId == sId)
              .userName,
          chatTitleTextStyle: const TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.25,
          ),
          userStatus: "online",
          userStatusTextStyle: const TextStyle(color: Colors.grey),
        ),
        chatBackgroundConfig: chat.ChatBackgroundConfiguration(
          messageTimeIconColor: white,
          messageTimeTextStyle: TextStyle(color: white),
          defaultGroupSeparatorConfig: chat.DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: white,
              fontSize: 17,
            ),
          ),
          backgroundColor: black,
        ),
        sendMessageConfig: chat.SendMessageConfiguration(
          imagePickerIconsConfig: chat.ImagePickerIconsConfiguration(
            cameraIconColor: white,
            galleryIconColor: white,
          ),
          replyMessageColor: Colors.blue,
          defaultSendButtonColor: accentColor,
          replyDialogColor: Colors.grey,
          replyTitleColor: white,
          textFieldBackgroundColor: blackAccent,
          closeIconColor: accentColor,
          textFieldConfig: chat.TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint(status.toString());
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: white),
          ),
          micIconColor: accentColor,
          voiceRecordingConfiguration: chat.VoiceRecordingConfiguration(
            backgroundColor: blackAccent,
            recorderIconColor: accentColor,
            waveStyle: chat.WaveStyle(
              showMiddleLine: false,
              waveColor: Colors.white,
              extendWaveform: true,
            ),
          ),
        ),
        chatBubbleConfig: chat.ChatBubbleConfiguration(
          outgoingChatBubbleConfig: chat.ChatBubble(
            linkPreviewConfig: chat.LinkPreviewConfiguration(
              backgroundColor: Colors.transparent,
              bodyStyle: Theme.of(context).textTheme.bodySmall,
              titleStyle: Theme.of(context).textTheme.titleSmall,
            ),
            receiptsWidgetConfig: const chat.ReceiptsWidgetConfig(
                showReceiptsIn: chat.ShowReceiptsIn.all),
            color: accentColor,
          ),
          inComingChatBubbleConfig: chat.ChatBubble(
            linkPreviewConfig: chat.LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: blackAccent,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: blackAccent,
              bodyStyle: Theme.of(context).textTheme.bodySmall,
              titleStyle: Theme.of(context).textTheme.titleSmall,
            ),
            textStyle: Theme.of(context).textTheme.bodySmall,
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle: Theme.of(context).textTheme.bodySmall,
            color: accentColor,
          ),
        ),
        replyPopupConfig: chat.ReplyPopupConfiguration(
          backgroundColor: Colors.grey,
          buttonTextStyle: Theme.of(context).textTheme.bodySmall,
          topBorderColor: accentColor,
        ),
        reactionPopupConfig: chat.ReactionPopupConfiguration(
          shadow: BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
          ),
          backgroundColor: blackAccent,
        ),
        messageConfig: chat.MessageConfiguration(
          messageReactionConfig: chat.MessageReactionConfiguration(
            backgroundColor: blackAccent,
            reactedUserCountTextStyle: Theme.of(context).textTheme.bodySmall,
            reactionCountTextStyle: Theme.of(context).textTheme.bodySmall,
            reactionsBottomSheetConfig: chat.ReactionsBottomSheetConfiguration(
              backgroundColor: blackAccent,
              reactedUserTextStyle: Theme.of(context).textTheme.bodySmall,
              reactionWidgetDecoration: BoxDecoration(
                color: accentColor,
                boxShadow: [
                  BoxShadow(
                    color: blackAccent,
                    offset: const Offset(0, 20),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: chat.ImageMessageConfiguration(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: chat.ShareIconConfiguration(
              defaultIconBackgroundColor: accentColor,
              defaultIconColor: accentColor,
            ),
          ),
        ),
        profileCircleConfig: chat.ProfileCircleConfiguration(
          profileImageUrl: _chatController.linikedList
              .singleWhere((element) => element.sId == sId)
              .profilePic,
        ),
        repliedMessageConfig: chat.RepliedMessageConfiguration(
          backgroundColor: blackAccent,
          repliedMsgAutoScrollConfig: chat.RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.pinkAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: white),
        ),
        swipeToReplyConfig: chat.SwipeToReplyConfiguration(
          replyIconColor: white,
        ),
      ),

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
