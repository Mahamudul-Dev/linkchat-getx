import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:linkchat/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:linkchat/app/modules/video_call/views/video_call_controll_bar_view.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/style/style.dart';

class VideoCallView extends GetView<VideoCallController> {
  VideoCallView({Key? key}) : super(key: key);
  final FollowersController _followersController = Get.find<FollowersController>();
  final int uid = Get.arguments['uid'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _followersController.followers
              .singleWhere((element) => element.data!.first.uid == uid)
              .data!.first.userName!,
          style: TextStyle(
            color: ThemeProvider().isSavedLightMood() ? black : brightWhite,
            fontSize: 19.sp
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(_followersController.followers
                .singleWhere((element) => element.data!.first.uid == uid).data!.first.profilePic!),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              return controller.isConnected.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: RTCVideoView(
                        controller.remoteRenderer,
                        mirror: true,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: black,
                      ),
                      child: const Center(
                        child: Text(
                          'Connecting..',
                          style: TextStyle(color: white),
                        ),
                      ),
                    );
            }),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Obx(
                      () => Container(
                        height: 150.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                controller.inCalling.value
                                    ? Colors.transparent
                                    : black),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: RTCVideoView(
                            controller.localRenderer,
                            objectFit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitCover,
                            mirror: true,
                          ),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const VideoCallControllBarView(),
    );
  }
}
