import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';

class ProfileCardView extends GetView<ProfileController> {
  const ProfileCardView({Key? key, required this.uid}) : super(key: key);
  final String uid;



  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: BoxDecoration(
            color: ThemeProvider().isSavedLightMood().value ? accentColor : black,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(alignment: Alignment.center, children: [
                CircleAvatar(
                  radius: 78.w,
                  backgroundColor: accentColor,
                ),
                // -- user profile photo display -- //
                CircleAvatar(
                    radius: 75.w,
                    backgroundColor: ThemeProvider().isSavedLightMood().value
                        ? brightWhite
                        : blackAccent,
                    backgroundImage: CachedNetworkImageProvider(uid !=
                            controller.getProfile.uid
                        ? Get.find<FollowersController>()
                                .followers
                                .singleWhere((element) =>
                                    element.uid.toString() == uid)
                                .profilePic ??
                            PLACEHOLDER_IMAGE
                        : controller.getProfile.photo ?? PLACEHOLDER_IMAGE)),
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
                      uid != controller.getProfile.uid!
                          ? Get.find<FollowersController>()
                                  .followers
                                  .singleWhere((element) =>
                                      element.uid.toString() == uid)
                                  .userName ??
                              'Unknown'
                          : controller.getProfile.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: brightWhite
                      ),
                      maxLines: 1,
                    ),

                    // -- user tagline display -- //
                    Text(
                      uid != controller.getProfile.uid
                          ? Get.find<FollowersController>()
                                  .followers
                                  .singleWhere((element) =>
                                      element.uid.toString() == uid)
                                  .tagLine ??
                              'Tag line not found in followers'
                          : controller.getProfile.tagline ??
                              'Not Found',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    // -- user uid display -- //
                    Text(
                        uid != controller.getProfile.uid
                            ? '@${Get.find<FollowersController>().followers.singleWhere((element) => element.uid.toString() == uid).uid ?? 'Not Found in followers'}'
                            : '@${controller.getProfile.uid}',
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.formatNumber(controller.getProfile.linkedCounts??0),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: brightWhite,
                                  ),
                                ),
                                Text(
                                    'Linked',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: brightWhite,
                                        fontWeight: FontWeight.normal
                                    )
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.formatNumber(controller.getProfile.followersCount??0),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: brightWhite,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: brightWhite,
                                    fontWeight: FontWeight.normal
                                  )
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.formatNumber(controller.getProfile.followingCounts ?? 00),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: brightWhite,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: brightWhite,
                                      fontWeight: FontWeight.normal
                                  ),
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
