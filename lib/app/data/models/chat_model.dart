class Chat {
  String userName;
  int uid;
  String? bio;
  String? profilePic;
  String? email;
  String gender;
  int? age;
  String? reletionshipStatus;
  String? about;
  int? unreadMessages;
  List<Message>? messages;
  bool? isActive;
  bool? isGroup;

  Chat(
      {required this.userName,
      required this.uid,
      this.bio,
      this.email,
      required this.gender,
      this.age,
      this.reletionshipStatus,
      this.about,
      this.profilePic,
      this.unreadMessages,
      this.messages,
      this.isActive,
      this.isGroup});
}

class Message {
  int sId;
  String message;
  DateTime timeStamp;
  bool isViewed;

  Message(
      {required this.sId,
      required this.message,
      required this.timeStamp,
      this.isViewed = false});
}
