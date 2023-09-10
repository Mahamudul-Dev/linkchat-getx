import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';

import '../../../data/models/user_model.dart';
import '../../../style/style.dart';
import '../../profile/views/about_card_view.dart';
import '../../profile/views/profile_card_view.dart';
import '../controllers/followers_controller.dart';
import 'follower_list_tile_view.dart';

class FollowersView extends GetView<FollowersController> {
  const FollowersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Followers')),
        body: FutureBuilder(
          future: controller.getFollowers(),
          builder: (context, AsyncSnapshot<List<ShortProfile>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircularShimmer(
                      height: 40,
                      width: 40,
                      radius: 40,
                    ),
                    title: SquareShimmer(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.8),
                    trailing: SquareShimmer(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.6),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'No data available',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showBottomSheet(
                      backgroundColor: solidMate,
                      elevation: 0,
                      context: context,
                      enableDrag: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(35))),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.9,
                          expand: true,
                          builder: (context, scrollController) {
                            return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(35),
                                        topRight: Radius.circular(35))),
                                child: ListView(
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  children: [
                                    ProfileCardView(
                                      sId: snapshot.data?[index].id
                                              .toString() ??
                                          'N/A',
                                      bgColor: solidMate,
                                    ),
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
                  child: FollowerListTileView(
                    serverId: snapshot.data![index].id,
                    userName: snapshot.data?[index].userName ?? '',
                    profilePic:
                        snapshot.data?[index].profilePic ?? PLACEHOLDER_IMAGE,
                    country: snapshot.data?[index].country ?? '',
                    isActive: snapshot.data?[index].isActive ?? false,
                    isChat: false,
                  ),
                );
              },
            );
          },
        ));
  }
}
