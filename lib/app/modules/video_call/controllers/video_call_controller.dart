import 'dart:core';
import 'package:flutter/material.dart';
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
            ElevatedButton(onPressed: (){connectCall();}, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(accentColor)), child: const Text('Give Permission', style: TextStyle(color: brightWhite),),)
          ],
        )
      );
    }
  }

  void hangUp() async {
    try {
      await localStream?.dispose();
      localRenderer.srcObject = null;
      inCalling.value = false;
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
