import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';

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
      body: NestedScrollView(
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
                          onPressed: () => Get.toNamed(Routes.ROOM_EXPLOR),
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
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const RoomCard(
                              roomPhoto: PLACEHOLDER_IMAGE,
                              roomName: 'Alu Bazar Bangladesh',
                              participantCount: 1788881,
                              onlineParticipantCount: 788);
                        }),
                  ),
                ],
              ),
            )
          ];
        },
        body:
            // Container()

            Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 5, left: 10),
                  child: Text(
                    'Your Rooms',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.toNamed(Routes.ROOM_CONVERSATION),
                        child: const RoomChatTile(
                            roomName: 'Freelancer Bangladesh',
                            roomDesc: 'This is a room'),
                      );
                    }))
          ],
        ),
      ),
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
