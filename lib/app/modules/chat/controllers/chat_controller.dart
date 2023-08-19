import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/database/database.dart';
import 'package:logger/logger.dart';

import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';

class ChatController extends GetxController {
// user activity list section
  List<FollowerModel> activeUser = [];
  List<FollowerModel> linikedList = [];
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;

// user chat section

  final dbHelper = DatabaseHelper();

  Future<List<FollowerModel>> getAllActiveUsers() async {
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + dbHelper.getUserData().serverId),
          headers: authorization(dbHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        activeUser = UserModel.fromJson(jsonDecode(response.body))
            .data
            .first
            .linked
            .where((element) => element.isActive == true)
            .toList();
        return activeUser;
      }

      return activeUser;
    } catch (e) {
      Logger().e(e);
      return activeUser;
    }
  }

  Future<List<ConversationSchema>> getConversation() async {
    conversations.clear();
    final conversationBox = dbHelper.conversationBox.query().build().find();
    for (var i = 0; i < conversationBox.length; i++) {
      RxList<MessageModel> messages = <MessageModel>[].obs;
      List<ChatParticipantModel> participants = [];
      for (var j = 0; j < conversationBox[i].messages.length; i++) {
        messages.add(MessageModel(content: conversationBox[i].messages[j].content, attachments: conversationBox[i].messages[j].attachment, users: [Users(sender: conversationBox[i].messages[j].sender.target!.serverId, receiver: conversationBox[i].messages[j].receiverId)], createdAt: conversationBox[i].messages[j].timestamp.toString(), updatedAt: conversationBox[i].messages[j].timestamp.toString()));
      }
      for (var k = 0; k < conversationBox[i].participant.length; i++) {
        participants.add(ChatParticipantModel(serverId: conversationBox[i].participant[k].serverId, uid: conversationBox[i].participant[k].uid, name: conversationBox[i].participant[k].name, photo: conversationBox[i].participant[k].photo, country: conversationBox[i].participant[k].country));
      }
      conversations.add(ConversationModel(conversationTitle: conversationBox[i].name, messages: messages, receiver: ChatParticipantModel(serverId: conversationBox[i].receiver.target!.serverId, uid: conversationBox[i].receiver.target!.uid, name: conversationBox[i].receiver.target!.name, photo: conversationBox[i].receiver.target!.photo, country: conversationBox[i].receiver.target!.country), participant: participants));
    }
    return conversationBox;
  }

  Future<void> getLinkedList()async{
    try{
      final response = await http.get(
          Uri.parse(BASE_URL + USER + dbHelper.getUserData().serverId),
          headers: authorization(dbHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        linikedList.clear();
        linikedList.addAll(UserModel.fromJson(jsonDecode(response.body))
            .data
            .first
            .linked);
      }
    } catch(e){
      Logger().e(e);
    }
  }

  @override
  void onInit() {
    getConversation();
    getLinkedList();
    Logger().i(conversations.length);
    super.onInit();
  }
}
