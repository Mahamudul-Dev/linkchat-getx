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
  int id;
  int uid;
  String message;
  DateTime timeStamp;
  bool isSent;

  Message(
      {required this.id,
      required this.uid,
      required this.message,
      required this.timeStamp,
      required this.isSent});
}
