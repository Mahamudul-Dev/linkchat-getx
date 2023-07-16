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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: Get.find<FollowersController>().followers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
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
                                        .data!.first.uid!),
                                AboutCardView(
                                    uid: Get.find<FollowersController>()
                                        .followers[index]
                                        .data!.first.uid!),
                              ],
                            ));
                      },
                    );
                  },
                );
              },
              child: SizedBox(
                height: 30,
                width: 30,
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: GridTile(
                      footer: Container(
                        color: blackAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: Text(
                          Get.find<FollowersController>()
                              .followers[index]
                              .data!.first.userName!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: brightWhite),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: Get.find<FollowersController>()
                            .followers[index]
                            .data!.first.profilePic!,
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
