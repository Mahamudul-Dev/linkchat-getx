//-- This file is created for make operation with ObjectBox database
//-- All database related CRUD & query operation related code need to be initialize in here
//-- File created at July 17 2023
//-- Creator: Mahamudul Hasan

import 'package:linkchat/app/data/utils/utils.dart';
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

  Future<void> saveConversation(String sId, Message message) async {

    final profile = ProfileController();
    UserModel? pUser;

    SocketIOService.socket.emit('', (data) {

    });

    try {
      await profile.getProfileDetails(sId).then((profile) => pUser = profile);
      if(pUser != null){
        try{
          conversationSchema = conversationBox.query(ConversationSchema_.receiverServerId.equals(pUser!.data.first.sId)).build().find().first;
        } catch (e){
          Logger().e(e);
        }

        final receiver = ChatParticipant(serverId: sId, uid: pUser!.data.first.uid, name: pUser!.data.first.userName, photo: pUser!.data.first.profilePic, country: pUser!.data.first.country);
        final sender = ChatParticipant(serverId: getUserData().serverId, uid: getUserData().uid ?? '', name: getUserData().name, photo: getUserData().photo?? PLACEHOLDER_IMAGE, country: getUserData().country ?? 'Unknown');


        if(conversationSchema == null){
          // save new conversation to database
          conversationSchema = ConversationSchema(name: pUser!.data.first.userName, receiverServerId: pUser!.data.first.sId);
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
}
