import 'dart:core';
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

  @override
  void onInit() {
    initRenderer();
    makeCall();
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

  makeCall() async {
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
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
    }
  }

  void hangUp() async {
    try {
      await localStream?.dispose();
      localRenderer.srcObject = null;
      inCalling.value = false;
      Get.back();
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
