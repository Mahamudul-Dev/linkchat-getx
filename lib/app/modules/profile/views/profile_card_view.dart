import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';

import '../../../data/models/user_model.dart';

class ProfileCardView extends GetView<ProfileController> {
  const ProfileCardView({
    Key? key,
    required this.sId,
    this.bgColor,
  }) : super(key: key);
  final String sId;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: BoxDecoration(
            color: bgColor ?? solidMate,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        child: Center(
            child: sId == controller.getCurrentProfile.serverId
                ? _buildOwnProfile(controller, context)
                : _buildOtherProfile(sId, controller, context)),
      ),
    );
  }
}

// own profile
Widget _buildOwnProfile(ProfileController controller, BuildContext context) {
  return Column(
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
            backgroundImage: CachedNetworkImageProvider(
                controller.getCurrentProfile.photo ?? PLACEHOLDER_IMAGE))
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
              controller.getCurrentProfile.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  overflow: TextOverflow.ellipsis, color: brightWhite),
              maxLines: 1,
            ),

            // -- user tagline display -- //
            Text(
              controller.getCurrentProfile.tagline ?? 'Not Found',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: white),
            ),
            const SizedBox(
              height: 5,
            ),

            // -- user uid display -- //
            Text('@${controller.getCurrentProfile.uid}',
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
                          controller.formatNumber(
                              controller.getCurrentProfile.linkedCounts ?? 0),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: brightWhite,
                                  ),
                        ),
                        Text('Linked',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: brightWhite,
                                    fontWeight: FontWeight.normal))
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
                          controller.formatNumber(
                              controller.getCurrentProfile.followersCount ?? 0),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: brightWhite,
                                  ),
                        ),
                        Text('Followers',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: brightWhite,
                                    fontWeight: FontWeight.normal))
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
                          controller.formatNumber(
                              controller.getCurrentProfile.followingCounts ??
                                  00),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: brightWhite,
                                  ),
                        ),
                        Text(
                          'Following',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: brightWhite,
                                  fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      )
    ],
  );
}

// other profile
Widget _buildOtherProfile(
    String sId, ProfileController controller, BuildContext context) {
  return FutureBuilder(
    future: controller.getProfileDetails(sId),
    builder: (context, AsyncSnapshot<UserModel?> snapshot) {
      if (snapshot.hasData) {
        return Column(
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
                  backgroundImage: CachedNetworkImageProvider(
                      snapshot.data?.data.first.profilePic ??
                          PLACEHOLDER_IMAGE))
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
                    snapshot.data?.data.first.userName ?? 'Unknown',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        overflow: TextOverflow.ellipsis, color: brightWhite),
                    maxLines: 1,
                  ),

                  // -- user tagline display -- //
                  Text(
                    snapshot.data?.data.first.tagLine ?? 'Not Found',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  // -- user uid display -- //
                  Text('@${snapshot.data?.data.first.uid}',
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
                                controller.formatNumber(
                                    snapshot.data?.data.first.linked.length ??
                                        0),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: brightWhite,
                                    ),
                              ),
                              Text('Linked',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          color: brightWhite,
                                          fontWeight: FontWeight.normal))
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
                                controller.formatNumber(snapshot
                                        .data?.data.first.followers.length ??
                                    0),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: brightWhite,
                                    ),
                              ),
                              Text('Followers',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          color: brightWhite,
                                          fontWeight: FontWeight.normal))
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
                                controller.formatNumber(snapshot
                                        .data?.data.first.following.length ??
                                    00),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: brightWhite,
                                    ),
                              ),
                              Text(
                                'Following',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: brightWhite,
                                        fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        );
      }

      return _buildLoadingShimmer(context);
    },
  );
}

Widget _buildLoadingShimmer(BuildContext context) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularShimmer(
            radius: 100,
            height: 120,
            width: 120,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SquareShimmer(
              height: 30, width: MediaQuery.of(context).size.width * 0.8)
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SquareShimmer(
              height: 30, width: MediaQuery.of(context).size.width * 0.5)
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SquareShimmer(height: 60, width: 100.w),
          SquareShimmer(height: 60, width: 100.w),
          SquareShimmer(height: 60, width: 100.w),
        ],
      )
    ],
  );
}
