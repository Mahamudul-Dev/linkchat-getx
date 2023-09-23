import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/multiple_profile_req_model.dart';
import 'package:linkchat/app/data/models/user_model.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/modules/room_chat/views/room_edit_view.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:logger/logger.dart';

import '../../../data/models/room_res_model.dart';
import '../controllers/room_conversation_controller.dart';
import 'room_chat_input_field.dart';

class RoomConversationView extends GetView<RoomConversationController> {
  RoomConversationView({super.key});

  final RoomModel roomModel = Get.arguments['room'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderBar(controller, roomModel, context),
      endDrawer: _buildDrawer(context, controller, roomModel),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: RoomConversationController.message.length,
                  itemBuilder: (context, index) {
                    return Obx(() => ListTile(
                          title:
                              Text(RoomConversationController.message[index]),
                        ));
                  }))),
          RoomChatInputField(roomId: roomModel.id),
        ],
      ),
    );
  }
}

AppBar _buildHeaderBar(RoomConversationController roomConversationController,
    RoomModel room, BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        const CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.groupName,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              _buildRoomMemberAvater(
                  roomConversationController: roomConversationController,
                  roomId: room.id,
                  context: context)
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildRoomMemberAvater(
    {required RoomConversationController roomConversationController,
    required String roomId,
    required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.5,
    height: 30,
    child: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 5) {
                return CircleAvatar(
                  radius: 8,
                  backgroundColor: blackAccent,
                  child: Center(
                    child: Text(
                      '${index - 5}+',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                );
              } else {
                return const CircleAvatar(
                  radius: 8,
                  backgroundColor: blackAccent,
                  backgroundImage:
                      CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
                );
              }
            },
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 3),
            itemCount: 6)),
  );
}

Widget _buildDrawer(BuildContext context, RoomConversationController controller,
    RoomModel room) {
  return Align(
    alignment: Alignment.centerRight,
    child: Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            backgroundColor: blackAccent,
            radius: 55.w,
            backgroundImage: CachedNetworkImageProvider(
                room.groupImage ?? PLACEHOLDER_IMAGE),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            room.groupName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            room.groupDescription,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              room.admins.contains(AccountHelper.getUserData().serverId)
                  ? IconButton(
                      onPressed: () => Get.toNamed(Routes.ROOM_EDIT_VIEW, arguments: {'room':room}),
                      icon: Column(
                        children: [
                          const Icon(Icons.edit),
                          Text(
                            'Edit',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ))
                  : room.settings.anyoneCanModifyGroup
                      ? IconButton(
                          onPressed: () => Get.toNamed(Routes.ROOM_EDIT_VIEW, arguments: {'room':room}),
                          icon: Column(
                            children: [
                              const Icon(Icons.edit),
                              Text(
                                'Edit',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ))
                      : const SizedBox.shrink(),
              room.admins.contains(AccountHelper.getUserData().serverId)
                  ? IconButton(
                      onPressed: () => Get.toNamed(Routes.ROOM_SETTINGS_VIEW),
                      icon: Column(
                        children: [
                          const Icon(Icons.settings),
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ))
                  : const SizedBox.shrink(),
              room.admins.contains(AccountHelper.getUserData().serverId)
                  ? IconButton(
                      onPressed: () => Get.toNamed(Routes.ROOM_MEMBER_VIEW,
                          arguments: {'room': room}),
                      icon: Column(
                        children: [
                          const Icon(Icons.group_add_rounded),
                          Text(
                            'Members',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ))
                  : room.settings.anyoneCanAddMember
                      ? IconButton(
                          onPressed: () => Get.toNamed(Routes.ROOM_MEMBER_VIEW,
                              arguments: {'room': room}),
                          icon: Column(
                            children: [
                              const Icon(Icons.group_add_rounded),
                              Text(
                                'Members',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ],
                          ))
                      : const SizedBox.shrink()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            controller: controller.drawerScrollController,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(color: blackAccent),
                    child: Column(
                      children: [
                        ListTile(
                            leading: const Icon(Icons.photo),
                            title: Text(
                              'Media Files:',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )),
                        Expanded(
                            child: GridView.builder(
                                controller: controller.drawerScrollController,
                                itemCount: 60,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisCount: 5),
                                itemBuilder: (context, index) {
                                  return GridTile(
                                      child: Container(
                                    color: Colors.blueGrey,
                                  ));
                                }))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(color: blackAccent),
                    child: Column(
                      children: [
                        ListTile(
                            leading:
                                const Icon(Icons.admin_panel_settings_rounded),
                            title: Text(
                              'Admins:',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            trailing: room.admins.length > 5
                                ? TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'See All',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  )
                                : const SizedBox.shrink()),
                        Expanded(
                            child: FutureBuilder(
                                future: ApiService.getMultipleProfile(
                                    GetMultipleProfileReqModel(
                                        idList: room.admins)),
                                builder: (context,
                                    AsyncSnapshot<GetMultipleProfileModel?>
                                        snapshot) {
                                  Logger().i(snapshot.data?.profiles.length);
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        controller:
                                            controller.drawerScrollController,
                                        itemCount:
                                            snapshot.data!.profiles.length > 5
                                                ? 5
                                                : snapshot
                                                    .data!.profiles.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(snapshot
                                                    .data
                                                    ?.profiles[index]
                                                    .userName ??
                                                'Unknown'),
                                            leading: CircleAvatar(
                                              backgroundColor: blackAccent,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      snapshot
                                                              .data
                                                              ?.profiles[index]
                                                              .profilePic ??
                                                          PLACEHOLDER_IMAGE),
                                            ),
                                            subtitle: Text(snapshot.data
                                                    ?.profiles[index].tagLine ??
                                                ''),
                                          );
                                        });
                                  }
                                  return ListView.builder(
                                      itemCount: room.admins.length,
                                      itemBuilder: (context, indes) {
                                        return SquareShimmer(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8);
                                      });
                                }))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ),
  );
}
