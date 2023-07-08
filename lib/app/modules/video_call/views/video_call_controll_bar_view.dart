import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:linkchat/app/style/style.dart';

class VideoCallControllBarView extends GetView<VideoCallController> {
  const VideoCallControllBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color:
          ThemeProvider().isSavedLightMood() ? brightWhite : transparentBlack,
      shadowColor: black,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  iconSize: 20,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.videoSlash,
                    color: ThemeProvider().isSavedLightMood()
                        ? black
                        : brightWhite,
                  )),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey,
              ),
              IconButton(
                  iconSize: 23,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.microphoneLines,
                    color: ThemeProvider().isSavedLightMood()
                        ? black
                        : brightWhite,
                  )),
              CircleAvatar(
                radius: 27.w,
                backgroundColor: Colors.red.shade700,
                child: IconButton(
                    onPressed: () => controller.hangUp(),
                    icon: const Icon(
                      Icons.call_end_rounded,
                      color: brightWhite,
                    )),
              ),
              IconButton(
                  iconSize: 23,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.cameraRotate,
                    color: ThemeProvider().isSavedLightMood()
                        ? black
                        : brightWhite,
                  )),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey,
              ),
              IconButton(
                  iconSize: 23,
                  onPressed: () {},
                  icon: Icon(
                    Icons.dashboard_rounded,
                    color: ThemeProvider().isSavedLightMood()
                        ? black
                        : brightWhite,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
