//-- This file is created for make operation with ObjectBox database
//-- All database related CRUD & query operation related code need to be initialize in here
//-- File created at July 17 2023
//-- Creator: Mahamudul Hasan

import './database.dart';
import '../data/models/models.dart';

class DatabaseHelper {
  // define all required boxes -->

  final currentUserBox = ObjectBoxSingleton().store.box<ProfileSchema>();
  final loginInfoBox = ObjectBoxSingleton().store.box<LoginSchema>();
  final notificationBox = ObjectBoxSingleton().store.box<NotificationSchema>();

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
}
