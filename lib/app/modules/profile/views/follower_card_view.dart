import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/modules/profile/views/profile_card_view.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';
import './about_card_view.dart';

class FollowerCardView extends GetView {
  const FollowerCardView({Key? key}) : super(key: key);
  //final int uid;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Get.find<FollowersController>().followers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () {
                showBottomSheet(
                  backgroundColor: white,
                  elevation: 0,
                  context: context,
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(35))),
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      expand: false,
                      builder: (context, scrollController) {
                        return Container(
                            decoration: BoxDecoration(
                                color: ThemeProvider().isSavedLightMood()
                                    ? white
                                    : solidMate,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35))),
                            child: ListView(
                              controller: scrollController,
                              shrinkWrap: true,
                              children: [
                                ProfileCardView(
                                    uid: Get.find<FollowersController>()
                                        .followers[index]
                                        .uid),
                                AboutCardView(
                                    uid: Get.find<FollowersController>()
                                        .followers[index]
                                        .uid),
                              ],
                            ));
                      },
                    );
                  },
                );
              },
              child: Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.all(3),
                child: Material(
                  elevation: 3,
                  child: GridTile(
                      footer: Container(
                        color: blackAccent,
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          Get.find<FollowersController>()
                              .followers[index]
                              .userName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: brightWhite),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: Get.find<FollowersController>()
                            .followers[index]
                            .userProfilePic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: accentColor,
                          ),
                        ),
                      )),
                ),
              ),
            );
          }),
    );
  }
}
