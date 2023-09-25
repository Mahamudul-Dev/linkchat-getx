import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  Connection? connection;
  MediaStream? localStream;
  RxBool inCalling = false.obs;
  RxBool isConnected = false.obs;

  RxBool isCameraOn = true.obs;
  RxBool isMicOn = true.obs;
  RxBool isFrontCamera = true.obs;

  @override
  void onInit() {
    initRenderer();
    connectCall();
    super.onInit();
  }

  @override
  void dispose() {
    remoteRenderer.dispose();
    localRenderer.dispose();
    localStream?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  // initialize renderer
  void initRenderer() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  connectCall() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      final Map<String, dynamic> mediaConstraints = {
        "audio": true,
        "video": {
          "mandatory": {
            "minWidth":
                '640', // Provide your own width, height and frame rate here
            "minHeight": '480',
            "minFrameRate": '30',
          },
          "facingMode": "user",
          "optional": [],
        }
      };

      try {
        await rtc.navigator.mediaDevices
            .getUserMedia(mediaConstraints)
            .then((stream) {
          localStream = stream;
          localRenderer.srcObject = localStream;
        });
      } catch (e) {
        Logger().e(e.toString());
      }

      inCalling.value = true;
    } else {
      Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: const Text('Camera'),
            content: const Text('You need to give access of your camera'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  connectCall();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(accentColor)),
                child: const Text(
                  'Give Permission',
                  style: TextStyle(color: brightWhite),
                ),
              )
            ],
          ));
    }
  }

  // Toggle camera on/off.
  void toggleCamera() {
    isCameraOn.value = !isCameraOn.value;
    localStream?.getVideoTracks().forEach((track) {
      track.enabled = isCameraOn.value;
    });
  }

  // Toggle microphone on/off.
  void toggleMic() {
    isMicOn.value = !isMicOn.value;
    localStream?.getAudioTracks().forEach((track) {
      track.enabled = isMicOn.value;
    });
  }

  void rotateCamera() {
    if (localStream != null) {
      localStream?.getVideoTracks().forEach((track) {
        // Stop the current camera track.
        track.stop();

        // Toggle between front and back cameras.
        isFrontCamera.value = !isFrontCamera.value;

        // Create new media constraints based on the camera selection.
        final cameraConstraints = {
          "facingMode": isFrontCamera.value ? "user" : "environment",
        };

        // Get user media with the new camera constraints.
        rtc.navigator.mediaDevices.getUserMedia(
            {"audio": true, "video": cameraConstraints}).then((newStream) {
          // Replace the old camera track with the new one.
          localStream?.getVideoTracks().first.enabled = isCameraOn.value;
          localStream?.removeTrack(track);
          localStream?.addTrack(newStream.getVideoTracks().first);
          localRenderer.srcObject = localStream; // Update the RTCVideoRenderer
          newStream.dispose();
        }).catchError((error) {
          Logger().e("Error switching camera: $error");
        });
      });
    }
  }

  void hangUp() async {
    try {
      // Create a copy of the video tracks to avoid concurrent modification.
      List<MediaStreamTrack> videoTracks = [...localStream!.getVideoTracks()];

      // Dispose of the video tracks.
      for (var track in videoTracks) {
        await track.stop();
      }

      // Dispose of the entire local stream.
      await localStream?.dispose();

      // Set the localRenderer srcObject to null.
      localRenderer.srcObject = null;
      inCalling.value = false;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  static Future<void> incommingCallRecieved(
      ShortProfileModel callerProfile) async {
    CallKitParams callKitParams = CallKitParams(
      id: callerProfile.sId,
      nameCaller: callerProfile.userName,
      appName: APP_NAME,
      avatar: callerProfile.profilePic,
      handle: callerProfile.uid,
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      duration: 30000,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#0955fa',
          backgroundUrl: 'https://i.pravatar.cc/500',
          actionColor: '#4CAF50',
          incomingCallNotificationChannelName: "Incoming Call",
          missedCallNotificationChannelName: "Missed Call"),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }
}
