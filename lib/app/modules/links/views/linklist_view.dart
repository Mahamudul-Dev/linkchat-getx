import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:linkchat/app/widgets/views/round_button_view.dart';
import 'package:linkchat/app/widgets/views/user_list_tile.dart';

import '../../../style/style.dart';
import '../../profile/views/about_card_view.dart';
import '../../profile/views/profile_card_view.dart';
import '../controllers/linklist_controller.dart';

class LinklistView extends GetView<LinklistController> {
  LinklistView({Key? key}) : super(key: key);
  final int? index = Get.arguments['index'];
  final bool? isChat = Get.arguments['isChat'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Link List')),
        body: index != null
            ? _buildScreen(controller, context)[index!]
            : _buildLinkList(controller, isChat ?? false));
  }
}

List<Widget> _buildScreen(LinklistController controller, BuildContext context) {
  return [
    Column(
      children: [
        Expanded(
            child: Scaffold(
          appBar: TabBar(
            controller: controller.tabController.value,
            indicatorColor: accentColor,
            labelColor: accentColor,
            unselectedLabelColor: brightWhite,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            tabs: const [
              Tab(
                text: 'Linked',
              ),
              Tab(
                text: 'Pending',
              )
            ],
          ),
          body: TabBarView(
            controller: controller.tabController.value,
            children: [
              _buildLinkList(controller, false),
              _buildLinkRequestLink(controller)
            ],
          ),
        ))
      ],
    ),
    Column(
      children: [
        Expanded(
            child: Scaffold(
          appBar: TabBar(
            controller: controller.tabController.value,
            indicatorColor: accentColor,
            labelColor: accentColor,
            unselectedLabelColor: brightWhite,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            tabs: const [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Linked',
              )
            ],
          ),
          body: TabBarView(
            controller: controller.tabController.value,
            children: [
              _buildLinkRequestLink(controller),
              _buildLinkList(controller, false)
            ],
          ),
        ))
      ],
    )
  ];
}

Widget _buildLinkList(LinklistController controller, bool isChat) {
  return FutureBuilder(
    future: controller.getLinkedList(),
    builder: (context, AsyncSnapshot<List<ShortProfileModel>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircularShimmer(
                height: 40,
                width: 40,
                radius: 40,
              ),
              title: SquareShimmer(
                  height: 16, width: MediaQuery.of(context).size.width * 0.8),
              trailing: SquareShimmer(
                  height: 16, width: MediaQuery.of(context).size.width * 0.6),
            );
          },
        );
      }
      if (snapshot.hasError) {
        return Center(
          child: Text(
            'Error when loading data',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }
      return ListView.builder(
        itemCount: snapshot.data?.length,
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
                                sId: snapshot.data?[index].sId.toString() ??
                                    'N/A',
                                bgColor: solidMate,
                              ),
                              AboutCardView(
                                  sId: snapshot.data?[index].sId.toString() ??
                                      'N/A'),
                            ],
                          ));
                    },
                  );
                },
              );
            },
            child: isChat
                ? ListTile(
                    leading: CircleAvatar(
                      backgroundColor: blackAccent,
                      backgroundImage: CachedNetworkImageProvider(
                          snapshot.data?[index].profilePic ??
                              PLACEHOLDER_IMAGE),
                    ),
                    title: Text(snapshot.data?[index].userName ?? 'Unknown'),
                    subtitle: Text(snapshot.data?[index].tagLine ?? ''),
                    trailing: RoundButtonView(
                      icon: Icons.send,
                      onTap: () => Get.offNamed(Routes.MESSAGE,
                          arguments: {'sId': snapshot.data?[index].sId}),
                    ),
                  )
                : UserListTile(
                    profilePic: snapshot.data?[index].profilePic,
                    userName: snapshot.data?[index].userName,
                    country: snapshot.data?[index].country,
                    onPresses: () => controller.handleFollow(
                        snapshot.data![index].sId,
                        snapshot.data?[index].userName ?? ''),
                    buttonStatus:
                        controller.getButtonStatus(snapshot.data![index].sId)),
          );
        },
      );
    },
  );
}

Widget _buildLinkRequestLink(LinklistController controller) {
  return FutureBuilder(
    future: controller.getPendingLinkList(),
    builder: (context, AsyncSnapshot<List<ShortProfileModel>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircularShimmer(
                height: 40,
                width: 40,
                radius: 40,
              ),
              title: SquareShimmer(
                  height: 16, width: MediaQuery.of(context).size.width * 0.8),
              trailing: SquareShimmer(
                  height: 16, width: MediaQuery.of(context).size.width * 0.6),
            );
          },
        );
      }
      if (snapshot.hasError) {
        return Center(
          child: Text(
            'Error when loading data',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }
      return ListView.builder(
        itemCount: snapshot.data?.length,
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
                                sId: snapshot.data?[index].sId.toString() ??
                                    'N/A',
                                bgColor: solidMate,
                              ),
                              AboutCardView(
                                  sId: snapshot.data?[index].sId.toString() ??
                                      'N/A'),
                            ],
                          ));
                    },
                  );
                },
              );
            },
            child: UserListTile(
                profilePic: snapshot.data?[index].profilePic,
                userName: snapshot.data?[index].userName,
                country: snapshot.data?[index].country,
                isActive: snapshot.data![index].isActive,
                onPresses: () => controller.handleFollow(
                    snapshot.data![index].sId,
                    snapshot.data?[index].userName ?? ''),
                buttonStatus:
                    controller.getButtonStatus(snapshot.data![index].sId)),
          );
        },
      );
    },
  );
}
