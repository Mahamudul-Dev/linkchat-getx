import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:linkchat/app/data/models/get_multiple_profile_req_model.dart';
import 'package:logger/logger.dart';

import '../../../data/models/linklist_model.dart';
import '../../../data/models/models.dart';
import '../../../data/utils/utils.dart';
import '../../../database/database.dart';
import '../../../database/helpers/helpers.dart';
import '../../../services/socket_io_service.dart';

class ChatController extends GetxController {
// user activity list section
  RxList<ShortProfile> activeUser = <ShortProfile>[].obs;
  List<ShortProfile> linikedList = [];
  static RxList<ConversationModel> conversations = <ConversationModel>[].obs;



  Future<List<ShortProfile>> getAllActiveUsers() async {
    activeUser.clear();
    try {
      final response = await http.get(
          Uri.parse(BASE_URL + USER + AccountHelper.getUserData().serverId),
          headers: authorization(AccountHelper.getLoginInfo().token!));

      if (response.statusCode == 200) {
        final List<Linked> data = UserModel.fromJson(jsonDecode(response.body))
            .data
            .first
            .linked;

        List<String> listOfId = [];

        for(int i = 0; i < data.length; i++){
          listOfId.add(data[i].id);
        }
        
        if(listOfId.isNotEmpty){

          final bodyData = GetMultipleProfileReqModel(idList: listOfId);

          final multipleUserRes = await http.post(
              Uri.parse(BASE_URL + MULTIPLE_USER),
              headers: authorization(AccountHelper.getLoginInfo().token!), body: bodyData.toJson());


          if(multipleUserRes.statusCode == 200){
            GetMultipleProfileModel profileList = GetMultipleProfileModel.fromJson(jsonDecode(multipleUserRes.body));
            activeUser.addAll(profileList.linkedList);
          }
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
    final conversationBox = P2PChatHelper.conversationBox.query().build().find();
    Logger().i(conversationBox.length);
    for (var i = 0; i < conversationBox.length; i++) {
      RxList<ReceiveMessageModel> messages = <ReceiveMessageModel>[].obs;
      List<ChatParticipantModel> participants = [];
      for (var j = 0; j < conversationBox[i].messages.length; j++) {
        messages.add(ReceiveMessageModel(
                message: conversationBox[i].messages[j].message,
                createdAt:
                    conversationBox[i].messages[j].createdAt.toIso8601String(),
                senderId: conversationBox[i].messages[j].senderServerId,
                receiverId: conversationBox[i].messages[j].receiverId,
                messageType: conversationBox[i].messages[j].messageType,
                voiceMessageDuration:
                    conversationBox[i].messages[j].voiceMessageDuration,
                status: conversationBox[i].messages[j].status)
            // ReceiveMessageModel(
            //   message: MessageModel(
            //       text: conversationBox[i].messages[j].content,
            //       attachments: conversationBox[i].messages[j].attachments),
            //   users: [
            //     conversationBox[i].messages[j].sender.target!.serverId,
            //     conversationBox[i].messages[j].receiverId
            //   ],
            //   createdAt: conversationBox[i].messages[j].timestamp.toString(),
            //   updatedAt: conversationBox[i].messages[j].timestamp.toString(),
            //   receiver: conversationBox[i].messages[j].receiverId,
            //   sender: conversationBox[i].messages[j].sender.target!.serverId)
            );
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
        List<Linked> linkedIdList = [];
        // linikedList.addAll(
        //     UserModel.fromJson(jsonDecode(response.body)).data.first.linked);
        linkedIdList.addAll(UserModel.fromJson(jsonDecode(response.body)).data.first.linked);

        try{
          List<String> listOfId = [];

          for(int i =0; i<linkedIdList.length; i++){
            listOfId.add(linkedIdList[i].id);
          }

          final bodyData = GetMultipleProfileReqModel(idList: listOfId);

          final multipleUserRes = await http.post(
              Uri.parse(BASE_URL + MULTIPLE_USER),
              headers: authorization(AccountHelper.getLoginInfo().token!), body: bodyData.toJson());


          if(multipleUserRes.statusCode == 200){
            GetMultipleProfileModel profileList = GetMultipleProfileModel.fromJson(jsonDecode(multipleUserRes.body));
            linikedList.addAll(profileList.linkedList);
          }
        } catch(e){
          Logger().e(e);
        }

      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void onInit() {
    getConversation();
    getLinkedList();
    Logger().i(conversations.length);
    SocketIOService.socket.on('getOnlineUser', (data){
      var uid = data['user_id'];
      Logger().i(uid);
      for(int i = 0; i<linikedList.length; i++){
        if(linikedList[i].id == uid){
          activeUser.add(linikedList[i]);
          return;
        }
      }

    });

    SocketIOService.socket.on('getOfflineUser', (data){
      var uid = data['user_id'];
      Logger().i(uid);
      for(int i = 0; i<linikedList.length; i++){
        if(linikedList[i].id == uid){
          activeUser.remove(linikedList[i]);
          return;
        }
      }

    });
    super.onInit();
  }
}
