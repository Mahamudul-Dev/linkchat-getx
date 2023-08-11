//-- This file is created for make operation with ObjectBox database
//-- All database related CRUD & query operation related code need to be initialize in here
//-- File created at July 17 2023
//-- Creator: Mahamudul Hasan

import 'package:logger/logger.dart';

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

  Future<void> saveConversation(ConversationSchema conversation,
      List<ChatParticipant> participants, List<Message> messages) async {
    await chatParticipantBox
        .putManyAsync(participants)
        .then((value) => Logger().d(chatParticipantBox.getAll()));
    await messageBox
        .putManyAsync(messages)
        .then((value) => Logger().d(messageBox.getAll()));
    await conversationBox.putAsync(conversation).then((value) {
      Logger().i(value);
      Logger().d(conversationBox.getAll());
    });
  }

  List<ConversationSchema> getConversation() {
    return conversationBox.query().build().find();
  }
}
