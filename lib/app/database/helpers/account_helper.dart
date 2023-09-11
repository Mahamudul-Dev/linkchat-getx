import '../../data/models/models.dart';
import '../database.dart';

class AccountHelper {
  static final currentUserBox = ObjectBoxSingleton().store.box<ProfileSchema>();
  static final loginInfoBox = ObjectBoxSingleton().store.box<LoginSchema>();

  static void saveEmailLoginInfo(EmailLoginResponseModel response) {
    loginInfoBox.removeAll();
    final data = LoginSchema(
        serverId: response.id!,
        userName: response.userName!,
        email: response.email!,
        token: response.token!);
    loginInfoBox.put(data);
  }

  static EmailLoginResponseModel getLoginInfo() {
    final data = loginInfoBox.getAll();
    final loginInfo = EmailLoginResponseModel(
        id: data.first.serverId,
        userName: data.first.userName,
        email: data.first.email,
        token: data.first.token);

    return loginInfo;
  }

  //** Save user profile information **//
  static Future<int> saveUserData(Profile user) {
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
        dob: user.dob.toString(),
        relationshipStatus: user.relationshipStatus,
        isActive: user.isActive,
        lastActive: user.lastActive,
        createdAt: user.createdAt);
    final objectId = currentUserBox.put(userProfile);
    return Future.value(objectId);
  }

  //** Get user profile **//
  static ProfileSchema getUserData() {
    final profileBox = currentUserBox.getAll();
    return profileBox.first;
  }
}
