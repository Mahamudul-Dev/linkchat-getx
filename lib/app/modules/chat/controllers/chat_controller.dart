import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/models/multiple_profile_req_model.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:logger/logger.dart';

import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';
import '../../../services/socket_io_service.dart';

class ChatController extends GetxController {
// user activity list section
  List<ShortProfileModel> activeUser = [];
  List<ShortProfileModel> linikedList = [];
  static RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  final dio = Dio();

  Future<List<ShortProfileModel>> getAllActiveUsers() async {
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

      List<String> linkedUserId = [];

      if (response.statusCode == 200) {
        Logger().i('Line: 33');
        for (var i = 0;
            i <
                UserModel.fromJson(jsonDecode(response.body))
                    .data
                    .first
                    .linked
                    .length;
            i++) {
          Logger().i('Loop running: $i');
          linkedUserId.add(UserModel.fromJson(jsonDecode(response.body))
              .data
              .first
              .linked[i]
              .sId);
          Logger().i(linkedUserId[i]);
        }
        Logger().i('Line: 50');
        final bodyData = GetMultipleProfileReqModel(idList: linkedUserId);
        final linkedUserProfileRes = await dio.post(
          BASE_URL + MULTIPLE_USER,
          data: bodyData.toJson(),
          options: Options(
              headers: authorization(AccountHelper.getLoginInfo().token!)),
        );

        Logger().i('Line: 58');

        Logger().i(linkedUserProfileRes.data);

        if (linkedUserProfileRes.statusCode == 200) {
          final allLinkedUserProfile =
              GetMultipleProfileModel.fromJson(linkedUserProfileRes.data);

          Logger().i(allLinkedUserProfile.profiles.length);

          activeUser.addAll(allLinkedUserProfile.profiles
              .where((element) => element.isActive == true));

          Logger().i(activeUser.length);
        }
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
    final conversationBox =
        P2PChatHelper.conversationBox.query().build().find();
    Logger().i(conversationBox.length);
    for (var i = 0; i < conversationBox.length; i++) {
      RxList<ReceiveMessageModel> messages = <ReceiveMessageModel>[].obs;
      List<ChatParticipantModel> participants = [];
      for (var j = 0; j < conversationBox[i].messages.length; j++) {
        messages.add(ReceiveMessageModel(
            message: MessageModel(
                text: conversationBox[i].messages[j].content,
                attachments: conversationBox[i].messages[j].attachments),
            users: [
              conversationBox[i].messages[j].sender.target!.serverId,
              conversationBox[i].messages[j].receiverId
            ],
            createdAt: conversationBox[i].messages[j].timestamp.toString(),
            updatedAt: conversationBox[i].messages[j].timestamp.toString(),
            receiver: conversationBox[i].messages[j].receiverId,
            sender: conversationBox[i].messages[j].sender.target!.serverId));
      }
      for (var k = 0; k < conversationBox[i].participant.length; k++) {
        participants.add(ChatParticipantModel(
            serverId: conversationBox[i].participant[k].serverId,
            uid: conversationBox[i].participant[k].uid,
            name: conversationBox[i].participant[k].name,
            photo: conversationBox[i].participant[k].photo,
            country: conversationBox[i].participant[k].country));
      }
      conversations.add(ConversationModel(
          conversationTitle: conversationBox[i].name,
          messages: messages,
          receiver: ChatParticipantModel(
              serverId: conversationBox[i].receiver.target!.serverId,
              uid: conversationBox[i].receiver.target!.uid,
              name: conversationBox[i].receiver.target!.name,
              photo: conversationBox[i].receiver.target!.photo,
              country: conversationBox[i].receiver.target!.country),
          participant: participants));
    }
    return conversationBox;
  }

  Future<void> getLinkedList() async {
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        linikedList.clear();
        linikedList.addAll(
            UserModel.fromJson(jsonDecode(response.body)).data.first.linked);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void onInit() {
    getConversation();
    getLinkedList();

    SocketIOService.socket.on('getOnlineUser', (data) {
      var uid = data['user_id'];
      Logger().i(uid);
      for (int i = 0; i < linikedList.length; i++) {
        if (linikedList[i].sId == uid) {
          activeUser.add(linikedList[i]);
          return;
        }
      }
    });

    SocketIOService.socket.on('getOfflineUser', (data) {
      var uid = data['user_id'];
      Logger().i(uid);
      for (int i = 0; i < linikedList.length; i++) {
        if (linikedList[i].sId == uid) {
          activeUser.remove(linikedList[i]);
          return;
        }
      }
    });

    Logger().i(conversations.length);
    super.onInit();
  }
}
