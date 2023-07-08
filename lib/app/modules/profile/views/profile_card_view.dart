import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';

class ProfileCardView extends GetView<ProfileController> {
  const ProfileCardView({Key? key,required this.uid}) : super(key: key);
  final int uid;

  @override
  Widget build(BuildContext context) {
    return Material(
            elevation: 3,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                  color:
                      ThemeProvider().isSavedLightMood() ? accentColor : black,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Stack(alignment: Alignment.center, children: [
                      CircleAvatar(
                        radius: 78.w,
                        backgroundColor: accentColor,
                      ),
                      // -- user profile photo display -- //
                      CircleAvatar(
                        radius: 75.w,
                        backgroundColor: ThemeProvider().isSavedLightMood()
                            ? brightWhite
                            : blackAccent,
                        backgroundImage: CachedNetworkImageProvider(
                          uid != Get.find<HomeController>().currentUser.uid
                            ? Get.find<FollowersController>().followers
                                .singleWhere((element) => element.uid == uid)
                                .userProfilePic : Get.find<HomeController>().currentUser.userProfilePic)
                            ,
                      ),
                    ]),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 250.w,
                      child: Column(
                        children: [
                          // -- user name display -- //
                          Text(
                            uid != Get.find<HomeController>().currentUser.uid
                            ? Get.find<FollowersController>().followers
                                .singleWhere((element) => element.uid == uid)
                                .userName
                            : Get.find<HomeController>().currentUser.userName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: brightWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),

                          // -- user tagline display -- //
                          Text(
                            uid != Get.find<HomeController>().currentUser.uid
                            ? Get.find<FollowersController>().followers.singleWhere((element) => element.uid == uid).tagline ?? ''
                            : Get.find<HomeController>().currentUser.tagline ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          // -- user uid display -- //
                          Text(
                            uid != Get.find<HomeController>().currentUser.uid
                            ? '@${Get.find<FollowersController>().followers.singleWhere((element) => element.uid == uid).uid}'
                            : '@${Get.find<HomeController>().currentUser.uid}',
                              style: const TextStyle(color: white))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 35,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.formatNumber(290000),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: brightWhite,
                                            fontSize: 16),
                                      ),
                                      const Text(
                                        'Followers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: brightWhite,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          Container(
                            height: 35,
                            width: 1,
                            color: brightWhite,
                          ),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 35,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.formatNumber(300000),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: brightWhite,
                                            fontSize: 16),
                                      ),
                                      const Text(
                                        'Following',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: brightWhite,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
