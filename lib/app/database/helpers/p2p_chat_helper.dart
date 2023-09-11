import 'package:get/get.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:logger/logger.dart';

import '../../../objectbox.g.dart';
import '../../data/models/models.dart';
import '../../modules/chat/controllers/chat_controller.dart';
import '../../modules/profile/controllers/profile_controller.dart';
import '../database.dart';
import '../objectbox_singleton.dart';
import 'helpers.dart';

class P2PChatHelper {
  static final conversationBox =
      ObjectBoxSingleton().store.box<ConversationSchema>();
  static ConversationSchema? conversationSchema;
  static final chatParticipantBox =
      ObjectBoxSingleton().store.box<ChatParticipantSchema>();
  static final messageBox = ObjectBoxSingleton().store.box<MessageSchema>();

  static Future<void> saveConversation(MessageSchema message) async {
    // final profile = ProfileController();
    UserModel? senderProfile;
    UserModel? receiverProfile;

    // try {
    //   await profile
    //       .getProfileDetails(message.sender.target!.serverId)
    //       .then((profile) => senderProfile = profile);
    //   await profile
    //       .getProfileDetails(message.receiverId)
    //       .then((profile) => receiverProfile = profile);
    //   if (senderProfile != null && receiverProfile != null) {
    //     try {
    //       conversationSchema = conversationBox
    //           .query(ConversationSchema_.receiverServerId
    //                   .equals(receiverProfile!.data.first.sId) |
    //               ConversationSchema_.creatorServerId
    //                   .equals(receiverProfile!.data.first.sId))
    //           .build()
    //           .find()
    //           .first;
    //     } catch (e) {
    //       Logger().e(e);
    //     }

    try {
      await ApiService.getSingleProfile(message.receiverId)
          .then((value) => receiverProfile = value);
      await ApiService.getSingleProfile(message.senderServerId)
          .then((value) => senderProfile = value);
      conversationSchema = conversationBox
          .query(ConversationSchema_.receiverServerId
                  .equals(message.receiverId) |
              ConversationSchema_.creatorServerId.equals(message.receiverId))
          .build()
          .findFirst();
    } catch (e) {
      Logger().e(e);
    }

    final receiver = ChatParticipantSchema(
        serverId: receiverProfile!.data.first.sId,
        uid: receiverProfile!.data.first.uid,
        name: receiverProfile!.data.first.userName,
        photo: receiverProfile!.data.first.profilePic,
        country: receiverProfile!.data.first.country);
    final sender = ChatParticipantSchema(
        serverId: senderProfile!.data.first.sId,
        uid: senderProfile!.data.first.uid,
        name: senderProfile!.data.first.userName,
        photo: senderProfile!.data.first.profilePic,
        country: senderProfile!.data.first.country);

    if (conversationSchema == null) {
      // save new conversation to database
      conversationSchema = ConversationSchema(
          name: receiverProfile!.data.first.sId ==
                  AccountHelper.getUserData().serverId
              ? senderProfile!.data.first.userName
              : receiverProfile!.data.first.userName,
          receiverServerId: receiverProfile!.data.first.sId,
          creatorServerId: senderProfile!.data.first.sId);
      message.sender.target = sender;
      message.conversation.target = conversationSchema;
      receiver.conversation.add(conversationSchema!);
      sender.conversation.add(conversationSchema!);
      conversationSchema?.receiver.target = receiver;
      conversationSchema?.messages.add(message);

      chatParticipantBox.putMany([receiver, sender]);
      messageBox.put(message);
      conversationBox.put(conversationSchema!);
      ChatController.conversations.add(ConversationModel(
          conversationTitle: receiverProfile!.data.first.sId ==
                  AccountHelper.getUserData().serverId
              ? senderProfile!.data.first.userName
              : receiverProfile!.data.first.userName,
          messages: [
            ReceiveMessageModel(
                message: message.message,
                createdAt: message.createdAt.toIso8601String(),
                senderId: message.senderServerId,
                receiverId: message.receiverId,
                messageType: message.messageType,
                voiceMessageDuration: message.voiceMessageDuration,
                status: message.status)
            // ReceiveMessageModel(
            //     message: MessageModel(
            //         text: message.content,
            //         attachments: message.attachments),
            //     users: [message.senderServerId, message.receiverId],
            //     sender: message.senderServerId,
            //     receiver: message.receiverId,
            //     createdAt: message.timestamp.toString(),
            //     updatedAt: message.timestamp.toString())
          ].obs,
          receiver: ChatParticipantModel(
              serverId: receiver.serverId,
              uid: receiver.uid,
              name: receiver.name,
              photo: receiver.photo,
              country: receiver.country),
          participant: [
            ChatParticipantModel(
                serverId: sender.serverId,
                uid: sender.uid,
                name: sender.name,
                photo: sender.photo,
                country: sender.country),
            ChatParticipantModel(
                serverId: receiver.serverId,
                uid: receiver.uid,
                name: receiver.name,
                photo: receiver.photo,
                country: receiver.country)
          ]));
    } else {
      // update existing conversation
      message.sender.target = sender;
      message.conversation.target = conversationSchema;
      conversationSchema?.messages.add(message);
      messageBox.put(message);
      conversationBox.put(conversationSchema!);
      ChatController.conversations
          .singleWhere((item) => item.receiver.serverId == message.receiverId)
          .messages
          .add(ReceiveMessageModel(
                  message: message.message,
                  createdAt: message.createdAt.toIso8601String(),
                  senderId: message.senderServerId,
                  receiverId: message.receiverId,
                  messageType: message.messageType,
                  voiceMessageDuration: message.voiceMessageDuration,
                  status: message.status)
              // ReceiveMessageModel(
              //   message: MessageModel(
              //       text: message.content, attachments: message.attachments),
              //   users: [message.senderServerId, message.receiverId],
              //   sender: message.senderServerId,
              //   receiver: message.receiverId,
              //   createdAt: message.timestamp.toString(),
              //   updatedAt: message.timestamp.toString())

              );
    }
  }

  //** Get all conversation from database **//
  static List<ConversationSchema> getConversation() {
    return conversationBox.query().build().find();
  }

  //** Get single conversation from database **//
  static ConversationSchema? getSingleConversation(String id) {
    ConversationSchema? schema;

    try {
      schema = conversationBox
          .query(ConversationSchema_.receiverServerId.equals(id))
          .build()
          .find()
          .first;
    } catch (e) {
      Logger().e(e);
    }

    return schema;
  }
}
