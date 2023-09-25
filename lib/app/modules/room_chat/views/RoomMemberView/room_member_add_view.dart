import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/models/room_res_model.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/links/controllers/linklist_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'room_member_controller.dart';

class RoomMemberAddView extends GetView<RoomMemberViewController> {
  RoomMemberAddView({super.key});
  final RoomModel room = Get.arguments['room'];

  final linklistController = Get.put(LinklistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Link List'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder(
                future: controller.getLinkedList(room),
                builder:
                    (context, AsyncSnapshot<List<ShortProfileModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Obx(() => controller.isLinkedScreenLoading.value
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: accentColor, size: 25),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: blackAccent,
                                  backgroundImage: CachedNetworkImageProvider(
                                      snapshot.data?[index].profilePic ??
                                          PLACEHOLDER_IMAGE),
                                ),
                                title: Text(snapshot.data?[index].userName ??
                                    'Unknown'),
                                subtitle: Text(
                                    snapshot.data?[index].tagLine ?? 'Unknown'),
                                trailing: Obx(() => Checkbox(
                                      value: controller
                                          .allLinked[index].isChecked.value,
                                      onChanged: (value) =>
                                          controller.selectionLinkedToggle(
                                              controller.allMemberList[index],
                                              index),
                                      checkColor: brightWhite,
                                      activeColor: accentColor,
                                    )),
                              );
                            },
                            itemCount: controller.allLinked.length,
                          ));
                  }
                  return ListView.builder(
                    itemBuilder: (context, snapshot) {
                      return ListTile(
                        title: SquareShimmer(
                            height: 15,
                            width: MediaQuery.of(context).size.width),
                        leading: const CircularShimmer(),
                        subtitle: SquareShimmer(
                            height: 10,
                            width: MediaQuery.of(context).size.width),
                      );
                    },
                    itemCount: 10,
                  );
                }),
            Obx(() => controller.selectableLinkedList.value
                ? Positioned(
                    bottom: 5,
                    left: 5,
                    right: 5,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(accentColor)),
                        onPressed: () => controller.addMember(room.id),
                        child: Text(
                          'Add To Room',
                          style: Theme.of(context).textTheme.labelMedium,
                        )))
                : const SizedBox.shrink())
          ],
        ));
  }
}
