//-- This file is created for make operation with ObjectBox database
//-- All database related CRUD & query operation related code need to be initialize in here
//-- File created at July 17 2023
//-- Creator: Mahamudul Hasan

import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/services/socket_io_service.dart';
import 'package:logger/logger.dart';

import '../../objectbox.g.dart';
import './database.dart';
import '../data/models/email_login_response_model.dart';
import '../data/models/user_model.dart';

class DatabaseHelper {
  // define all required boxes -->

  final currentUserBox = ObjectBoxSingleton().store.box<ProfileSchema>();
  final loginInfoBox = ObjectBoxSingleton().store.box<LoginSchema>();
  final notificationBox = ObjectBoxSingleton().store.box<NotificationSchema>();
  final conversationBox = ObjectBoxSingleton().store.box<ConversationSchema>();
  final chatParticipantBox = ObjectBoxSingleton().store.box<ChatParticipant>();
  final messageBox = ObjectBoxSingleton().store.box<Message>();

  ConversationSchema? conversationSchema;

  void saveEmailLoginInfo(EmailLoginResponseModel response) {
    loginInfoBox.removeAll();
    final data = LoginSchema(
        serverId: response.id!,
        userName: response.userName!,
        email: response.email!,
        token: response.token!);
    loginInfoBox.put(data);
  }

  EmailLoginResponseModel getLoginInfo() {
    final data = loginInfoBox.getAll();
    final loginInfo = EmailLoginResponseModel(
        id: data.first.serverId,
        userName: data.first.userName,
        email: data.first.email,
        token: data.first.token);

    return loginInfo;
  }

  Future<int> saveUserData(Data user) {
    currentUserBox.removeAll();
    final userProfile = ProfileSchema(
        serverId: user.sId,
        uid: user.uid,
        name: user.userName,
        email: user.email,
        phone: user.userPhone,
        photo: user.profilePic,
        tagline: user.tagLine,
        bio: user.bio,
        gender: user.gender,
        country: user.country,
        followersCount: user.followers.length,
        followingCounts: user.following.length,
        linkedCounts: user.linked.length,
        dob: user.dob,
        relationshipStatus: user.relationshipStatus,
        isActive: user.isActive,
        lastActive: user.lastActive,
        createdAt: user.createdAt);
    final objectId = currentUserBox.put(userProfile);
    return Future.value(objectId);
  }

  ProfileSchema getUserData() {
    final profileBox = currentUserBox.getAll();
    return profileBox.first;
  }

  void saveNotification(NotificationSchema notificationSchema) {
    notificationBox.put(notificationSchema);
  }

  Future<void> saveConversation(Message message) async {

    final profile = ProfileController();
    UserModel? senderProfile;
    UserModel? receiverProfile;

    try {
      await profile.getProfileDetails(message.senderServerId).then((profile) => senderProfile = profile);
      await profile.getProfileDetails(message.receiverId).then((profile) => receiverProfile = profile);
      if(senderProfile != null && receiverProfile!=null){
        try{
          conversationSchema = conversationBox.query(ConversationSchema_.receiverServerId.equals(receiverProfile!.data.first.sId) | ConversationSchema_.creatorServerId.equals(receiverProfile!.data.first.sId)).build().find().first;
        } catch (e){
          Logger().e(e);
        }

        final receiver = ChatParticipant(serverId: receiverProfile!.data.first.sId, uid: receiverProfile!.data.first.uid, name: receiverProfile!.data.first.userName, photo: receiverProfile!.data.first.profilePic, country: receiverProfile!.data.first.country);
        final sender = ChatParticipant(serverId: senderProfile!.data.first.sId, uid: senderProfile!.data.first.uid, name: senderProfile!.data.first.userName, photo: senderProfile!.data.first.profilePic, country: senderProfile!.data.first.country);


        if(conversationSchema == null){
          // save new conversation to database
          conversationSchema = ConversationSchema(name: receiverProfile!.data.first.sId == getUserData().serverId ? senderProfile!.data.first.userName : receiverProfile!.data.first.userName, receiverServerId: receiverProfile!.data.first.sId, creatorServerId: senderProfile!.data.first.sId);
          message.sender.target = sender;
          message.conversation.target = conversationSchema;
          receiver.conversation.add(conversationSchema!);
          sender.conversation.add(conversationSchema!);
          conversationSchema?.receiver.target = receiver;
          conversationSchema?.messages.add(message);

          chatParticipantBox.putMany([receiver, sender]);
          messageBox.put(message);
          conversationBox.put(conversationSchema!);
        } else {
          // update existing conversation
          message.sender.target = sender;
          message.conversation.target = conversationSchema;
          conversationSchema?.messages.add(message);
          messageBox.put(message);
          conversationBox.put(conversationSchema!);
        }

      }
    } catch(e){
      Logger().e(e);
    }
  }

  List<ConversationSchema> getConversation() {
    return conversationBox.query().build().find();
  }

  ConversationSchema? getSingleConversation(String sId){

    ConversationSchema? schema;
    
    try{
      schema = conversationBox.query(ConversationSchema_.receiverServerId.equals(sId)).build().find().first;
    } catch(e){
      Logger().e(e);
    }

    return schema;
  }

  // Stream<List<Message>>? streamSingleConversation (String sId){
  //   try{
  //     final query = messageBox.query(Message_.senderServerId.equals(sId));
  //     return query.watch(triggerImmediately: true).map((event) {
  //       Logger().i(event.find()[0].message);
  //       MessageController.messages.addAll(event.find());
  //       return event.find();
  //     });
  //   } catch(e){
  //     Logger().e(e);
  //     return null;
  //   }
  // }
}
