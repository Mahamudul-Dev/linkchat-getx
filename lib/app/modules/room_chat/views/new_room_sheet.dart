import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/modules/room_chat/controllers/room_chat_controller.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';
import 'package:linkchat/app/widgets/views/search_bar_view.dart';

import '../../../database/helpers/helpers.dart';
import '../../../style/style.dart';

class NewRoomSheet extends GetView<RoomChatController> {
  const NewRoomSheet({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: black),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Create New Room',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(() => ElevatedButton(
                  onPressed: () => controller.createRoom(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          controller.selectedLink.isNotEmpty
                              ? accentColor
                              : blackAccent)),
                  child: Text(
                    'Create',
                    style: Theme.of(context).textTheme.labelMedium,
                  )))
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 3,
                child: SearchBarView(
                    height: 50,
                    hint: 'Search Linked',
                    onchanged: (query) => controller.queryLink(query)),
              ),
              Expanded(
                  flex: 1,
                  child: Obx(
                    () => DropdownButton<String>(
                      style: Theme.of(context).textTheme.labelSmall,
                      value: controller.selectedVisibility.value,
                      onChanged: (newValue) {
                        controller.selectedVisibility.value = newValue!;
                      },
                      items: controller.groupVisibilityItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ))
            ],
          ),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                EditTextFieldView(
                  controller: controller.groupNameController,
                  iconData: Icons.group,
                  hintText: 'Type Room Name',
                ),
                const SizedBox(width: 5),
                const SizedBox(height: 15),
                Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        color: blackAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Obx(() => controller.selectedLink.isEmpty
                        ? const Center(
                            child: Text('No Member Selected'),
                          )
                        : GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemCount: controller.selectedLink.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: CachedNetworkImageProvider(controller
                                        .selectedLink[index].profilePic),
                                    fit: BoxFit.cover,
                                  ));
                            }))),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Your Link',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                    height: 400,
                    child: FutureBuilder(
                        future: ApiService.getSingleProfile(
                            AccountHelper.getUserData().serverId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Obx(() => ListView.builder(
                                  controller: scrollController,
                                  itemCount: controller.linkList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: blackAccent,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  controller.linkList[index]
                                                      .profilePic),
                                        ),
                                        title: Text(
                                          controller.linkList[index].userName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        trailing: Obx(() => Checkbox(
                                            checkColor: white,
                                            activeColor: accentColor,
                                            value: controller.selectedLink
                                                .contains(
                                                    controller.linkList[index]),
                                            onChanged: (value) =>
                                                controller.toggleItem(controller
                                                    .linkList[index]))));
                                  },
                                ));
                          }
                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return SquareShimmer(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width);
                              });
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
