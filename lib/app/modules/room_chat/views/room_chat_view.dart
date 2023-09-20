import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/room_res_model.dart';
import '../../../database/helpers/helpers.dart';
import '../../../routes/app_pages.dart';
import '../controllers/room_chat_controller.dart';
import 'new_room_sheet.dart';
import 'room_card.dart';
import 'room_chat_tail.dart';

class RoomChatView extends GetView<RoomChatController> {
  const RoomChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
        centerTitle: false,
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: LoadingAnimationWidget.bouncingBall(
                  color: accentColor, size: 25),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, innerSliverIsScrollable) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                'Explore',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            TextButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.ROOM_EXPLOR),
                                child: Text(
                                  'See all',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            // padding: const EdgeInsets.all(20),
                            child: FutureBuilder(
                                future: controller.getPublicRooms(),
                                builder: (context,
                                    AsyncSnapshot<RoomResModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data!.data.length > 5
                                                ? 5
                                                : snapshot.data!.data.length,
                                        itemBuilder: (context, index) {
                                          return RoomCard(
                                            buttonText: snapshot
                                                    .data!.data[index].members
                                                    .contains(AccountHelper
                                                            .getUserData()
                                                        .serverId)
                                                ? 'View'
                                                : 'Join',
                                            onTap: () => snapshot
                                                    .data!.data[index].members
                                                    .contains(AccountHelper
                                                            .getUserData()
                                                        .serverId)
                                                ? Get.toNamed(
                                                    Routes.ROOM_CONVERSATION,
                                                    arguments: {
                                                        'room': snapshot
                                                            .data?.data[index]
                                                      })
                                                : controller.joinRoom(snapshot
                                                    .data!
                                                    .data[index]
                                                    .joinCode),
                                            roomPhoto: snapshot
                                                        .data
                                                        ?.data[index]
                                                        .groupImage !=
                                                    null
                                                ? '$BASE_URL${snapshot.data?.data[index].groupImage}'
                                                : PLACEHOLDER_IMAGE,
                                            roomName: snapshot.data?.data[index]
                                                    .groupName ??
                                                'Unknown',
                                            participantCount: snapshot
                                                    .data
                                                    ?.data[index]
                                                    .members
                                                    .length ??
                                                0,
                                            onlineParticipantCount: 788,
                                            memberLimit: snapshot
                                                    .data
                                                    ?.data[index]
                                                    .settings
                                                    .memberLimit ??
                                                0,
                                            nudeProtection: snapshot
                                                        .data
                                                        ?.data[index]
                                                        .settings
                                                        .nudeProtection ??
                                                    false
                                                ? 'Enabled'
                                                : 'Deactivated',
                                            joiningCode: snapshot.data
                                                    ?.data[index].joinCode ??
                                                0,
                                            whoCanMessage: snapshot
                                                    .data
                                                    ?.data[index]
                                                    .settings
                                                    .whoCanMessage ??
                                                'Everyone',
                                          );
                                        });
                                  }

                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SquareShimmer(
                                          height: 170, width: 130);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 5,
                                      );
                                    },
                                  );
                                })),
                      ],
                    ),
                  )
                ];
              },
              body: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 5, left: 10),
                        child: Text(
                          'Your Rooms',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder(
                          future: controller.getAllJoinedRooms(),
                          builder:
                              (context, AsyncSnapshot<RoomResModel?> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.data.isEmpty) {
                                return Center(
                                  child: Text(
                                    "You're not joined any room",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!.data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Get.toNamed(
                                          Routes.ROOM_CONVERSATION,
                                          arguments: {
                                            'room': snapshot.data!.data[index]
                                          }),
                                      child: RoomChatTile(
                                        room: snapshot.data!.data[index],
                                      ),
                                    );
                                  });
                            }
                            return ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const CircularShimmer(),
                                    title: SquareShimmer(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width),
                                    subtitle: SquareShimmer(
                                        height: 8,
                                        width:
                                            MediaQuery.of(context).size.width),
                                  );
                                });
                          }))
                ],
              ),
            )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.5,
                  minChildSize: 0.1,
                  maxChildSize: 1.0,
                  builder: (context, scrollController) {
                    return NewRoomSheet(
                      scrollController: scrollController,
                    );
                  },
                );
              });
        },
        label: const Row(
          children: [
            Text(
              'New Room',
              style: TextStyle(color: brightWhite, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(Icons.add)
          ],
        ),
        backgroundColor: accentColor,
      ),
    );
  }
}
