import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';

class ChatProfileBarView extends GetView {
  const ChatProfileBarView({Key? key, required this.profilePic, required this.name, required this.tagLine, required this.isActive, required this.uid,}) : super(key: key);
  final String profilePic;
  final String name;
  final String tagLine;
  final bool isActive;
  final int uid;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130,
      floating: true,
      backgroundColor: ThemeProvider().isSavedLightMood() ? brightWhite : black,
      title: Text(name),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              size: 25.w,
              color: ThemeProvider().isSavedLightMood() ? black : brightWhite,
            ))
      ],
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: ThemeProvider().isSavedLightMood()
                            ? const Color(0x72000000)
                            : const Color.fromARGB(113, 60, 60, 60),
                        blurRadius: 17.54,
                        offset: const Offset(9, 9),
                      ),
                    ]),
                    child: CircleAvatar(
                      backgroundColor:
                          ThemeProvider().isSavedLightMood() ? white : black,
                      radius: 30.w,
                      backgroundImage: CachedNetworkImageProvider(profilePic),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle,
                            color: isActive ? Colors.green : Colors.red,
                            size: 15,
                          ),
                          const SizedBox(width: 3),
                          Text(isActive ? 'Online' : 'Offline',
                              style: TextStyle(
                                  color: isActive ? Colors.green : Colors.red))
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(tagLine,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ThemeProvider().isSavedLightMood()
                                    ? black
                                    : white)),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call_rounded,
                      color: ThemeProvider().isSavedLightMood()
                          ? accentColor
                          : brightWhite,
                      size: 25.w,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(Routes.VIDEO_CALL,
                        arguments: {'uid': uid}),
                    icon: Icon(
                      Icons.video_call_rounded,
                      color: ThemeProvider().isSavedLightMood()
                          ? accentColor
                          : brightWhite,
                      size: 25.w,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
