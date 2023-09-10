import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/modules/profile/views/profile_card_view.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './about_card_view.dart';
import '../../followers/controllers/followers_controller.dart';

class FollowerCardView extends GetView<FollowersController> {
  const FollowerCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        child: FutureBuilder(
          future: controller.getFollowers(),
          builder: (context, AsyncSnapshot<List<ShortProfile>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'There was some error, please check your connection.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            if (snapshot.hasData) {
              return GridView.builder(
                  controller: Get.find<ProfileController>().scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.length,
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(35))),
                          builder: (context) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.6,
                              expand: false,
                              builder: (context, scrollController) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: ThemeProvider()
                                                .isSavedLightMood()
                                                .value
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
                                            sId: snapshot.data?[index].id
                                                    .toString() ??
                                                'N/A'),
                                        AboutCardView(
                                            sId: snapshot.data?[index].id
                                                    .toString() ??
                                                'N/A'),
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
                          child: GridTile(
                              footer: Container(
                                color: transparentBlack,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Text(
                                  snapshot.data?[index].userName ?? "N/A",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: brightWhite),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data?[index].profilePic ??
                                    PLACEHOLDER_IMAGE,
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
                  });
            }

            return Container(
              color: ThemeProvider().isSavedLightMood().value
                  ? brightWhite
                  : solidMate,
              child: Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: accentColor, size: 50.w),
              ),
            );
          },
        ));
  }
}
