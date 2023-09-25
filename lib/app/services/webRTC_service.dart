// ignore_for_file: slash_for_doc_comments

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/services/socket_io_service.dart';
import 'package:logger/logger.dart';

import '../data/models/models.dart';

/**
 * SecMeet WebRTC connection file!
 * created date: 22-09-2023
 * created by: Mahamudul Hasan
 */
class WebRTCService {
  static late RTCPeerConnection peerConnection;

  static Future<void> establishPeerConnectionForCreator(
      ShortProfileModel recieverProfile) async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveVideo': true,
        'OfferToReceiveAudio': true,
      },
      'optional': [],
    };

    peerConnection = await createPeerConnection(configuration, constraints);
    peerConnection.onIceCandidate = (candidate) {
      SocketIOService.socket.emit('ice-candidate',
          {'targetId': recieverProfile.sId, 'candidate': candidate.toMap()});
    };

    peerConnection.onTrack = (track) {
      VideoCallController.remoteRenderer.srcObject = track.streams[0];
    };
    peerConnection.createOffer().then((offer) {
      Logger().i('Offer Created from user : $offer');
      SocketIOService.socket.emit(
          'offer', {'offer': offer, 'callerDetails': recieverProfile.toJson()});
      peerConnection.setLocalDescription(offer);
      Get.toNamed(Routes.VIDEO_CALL, arguments: {'profile': recieverProfile});
    });
    Logger().i('Local Stream: ${VideoCallController.localStream?.getTracks()}');
    if (VideoCallController.localStream != null) {
      peerConnection.addTrack(VideoCallController.localStream!.getTracks()[0],
          VideoCallController.localStream!);
      peerConnection.addTrack(VideoCallController.localStream!.getTracks()[1],
          VideoCallController.localStream!);
    }
  }

  static Future<void> establishPeerConnectionForReciver(
      ShortProfileModel callerProfile, RTCSessionDescription offer) async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    final Map<String, dynamic> constraints = {
      'mandatory': {
        'OfferToReceiveVideo': true,
        'OfferToReceiveAudio': true,
      },
      'optional': [],
    };

    peerConnection = await createPeerConnection(configuration, constraints);
    peerConnection.onIceCandidate = (candidate) {
      SocketIOService.socket.emit('ice-candidate',
          {'targetId': callerProfile.sId, 'candidate': candidate.toMap()});
    };

    peerConnection.onTrack = (track) {
      VideoCallController.remoteRenderer.srcObject = track.streams[0];
    };

    Logger().i('Local Stream: ${VideoCallController.localStream?.getTracks()}');
    if (VideoCallController.localStream != null) {
      peerConnection.addTrack(VideoCallController.localStream!.getTracks()[0],
          VideoCallController.localStream!);
      peerConnection.addTrack(VideoCallController.localStream!.getTracks()[1],
          VideoCallController.localStream!);
    }
    peerConnection.setRemoteDescription(offer);
    await peerConnection.createAnswer().then((answer) {
      peerConnection.setLocalDescription(answer);
      SocketIOService.socket
          .emit('answer', {'answer': answer, 'userID': callerProfile.sId});
      Get.toNamed(Routes.VIDEO_CALL, arguments: {'profile': callerProfile});
    });
  }
}
