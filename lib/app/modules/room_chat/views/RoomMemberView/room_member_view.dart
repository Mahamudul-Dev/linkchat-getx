import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/models.dart';
import '../../../../data/models/room_res_model.dart';
import '../../../../database/helpers/helpers.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/style.dart';
import '../../../../widgets/views/SquareShimmer.dart';
import 'room_member_controller.dart';

class RoomMemberView extends GetView<RoomMemberViewController> {
  RoomMemberView({Key? key}) : super(key: key);

  final RoomModel room = Get.arguments['room'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(room.groupName),
          bottom: TabBar(
            controller: controller.tabController.value,
            tabs: const [
              Tab(
                text: 'Members',
              ),
              Tab(
                text: 'Admins',
              )
            ],
            labelColor: accentColor,
            indicatorColor: accentColor,
          ),
        ),
        body: TabBarView(controller: controller.tabController.value, children: [
          _buildMemberList(room, controller, context),
          _buildAdminList(room, controller, context)
        ]),
        floatingActionButton: room.admins
                .contains(AccountHelper.getUserData().serverId)
            ? Obx(() => controller.selectableAdminList.value == false &&
                    controller.selectableMemberList.value == false
                ? FloatingActionButton.extended(
                    backgroundColor: accentColor,
                    onPressed: () => Get.toNamed(Routes.ROOM_MEMBER_ADD_VIEW),
                    label: Text(
                      'Add Member',
                      style: Theme.of(context).textTheme.labelMedium,
                    ))
                : const SizedBox.shrink())
            : const SizedBox.shrink());
  }
}

Widget _buildMemberList(
    RoomModel room, RoomMemberViewController controller, BuildContext context) {
  return FutureBuilder(
      future: controller.getAllMember(room.members, room),
      builder: (context, AsyncSnapshot<GetMultipleProfileModel?> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Obx(() => ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                          onLongPress: () {
                            if (room.admins.contains(
                                AccountHelper.getUserData().serverId)) {
                              controller.selectionMemberToggle(
                                  controller.allMemberList[index], index);
                            }
                          },
                          onTap: () {
                            if (controller.selectableMemberList.value) {
                              controller.selectionMemberToggle(
                                  controller.allMemberList[index], index);
                            }
                          },
                          title: Text(
                            controller.allMemberList[index].userName,
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: blackAccent,
                            backgroundImage: CachedNetworkImageProvider(
                                controller.allMemberList[index].profilePic),
                          ),
                          subtitle: Text(
                            controller.allMemberList[index].tagline ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Obx(() => controller
                                  .selectableMemberList.value
                              ? room.creatorId ==
                                      AccountHelper.getUserData().serverId
                                  ? Obx(() => Checkbox(
                                        value: controller.allMemberList[index]
                                            .isChecked.value,
                                        onChanged: (value) =>
                                            controller.selectionMemberToggle(
                                                controller.allMemberList[index],
                                                index),
                                        checkColor: brightWhite,
                                        activeColor: accentColor,
                                      ))
                                  : const SizedBox.shrink()
                              : const SizedBox.shrink()));
                    },
                    itemCount: controller.allMemberList.length,
                  )),
              Obx(() => controller.selectableMemberList.value
                  ? Positioned(
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(blackAccent)),
                              child: Text(
                                'Remove',
                                style: Theme.of(context).textTheme.labelSmall,
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(accentColor)),
                              child: Text(
                                'Make Admin',
                                style: Theme.of(context).textTheme.labelSmall,
                              ))
                        ],
                      ))
                  : const SizedBox.shrink())
            ],
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: SquareShimmer(
                  height: 10, width: MediaQuery.of(context).size.width),
            );
          },
          itemCount: 10,
        );
      });
}

Widget _buildAdminList(
    RoomModel room, RoomMemberViewController controller, BuildContext context) {
  return FutureBuilder(
      future: controller.getAllAdmin(room.admins),
      builder: (context, AsyncSnapshot<GetMultipleProfileModel?> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Obx(() => ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                          onLongPress: () {
                            if (room.admins.contains(
                                    AccountHelper.getUserData().serverId) &&
                                controller.allAdminList[index].serverId !=
                                    AccountHelper.getUserData().serverId) {
                              controller.selectionAdminToggle(
                                  controller.allAdminList[index], index);
                            } else {
                              Get.snackbar('Sorry', 'You cant remove yourself');
                            }
                          },
                          onTap: () {
                            if (controller.selectableAdminList.value) {
                              controller.selectionAdminToggle(
                                  controller.allAdminList[index], index);
                            }
                          },
                          title: Text(
                            controller.allAdminList[index].userName,
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: blackAccent,
                            backgroundImage: CachedNetworkImageProvider(
                                controller.allAdminList[index].profilePic),
                          ),
                          subtitle: Text(
                            controller.allAdminList[index].tagline ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Obx(() => controller
                                  .selectableAdminList.value
                              ? room.creatorId ==
                                      AccountHelper.getUserData().serverId
                                  ? snapshot.data!.profiles[index].sId ==
                                          AccountHelper.getUserData().serverId
                                      ? const SizedBox.shrink()
                                      : Obx(() => Checkbox(
                                            value: controller
                                                .allAdminList[index]
                                                .isChecked
                                                .value,
                                            onChanged: (value) => controller
                                                    .allAdminList[index]
                                                    .isChecked
                                                    .value =
                                                !controller.allAdminList[index]
                                                    .isChecked.value,
                                            checkColor: brightWhite,
                                            activeColor: accentColor,
                                          ))
                                  : const SizedBox.shrink()
                              : const SizedBox.shrink()));
                    },
                    itemCount: controller.allAdminList.length,
                  )),
              Obx(() => controller.selectableAdminList.value
                  ? Positioned(
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(accentColor)),
                          child: Text(
                            'Remove Admin',
                            style: Theme.of(context).textTheme.labelSmall,
                          )))
                  : const SizedBox.shrink())
            ],
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: SquareShimmer(
                  height: 10, width: MediaQuery.of(context).size.width),
            );
          },
          itemCount: 10,
        );
      });
}
