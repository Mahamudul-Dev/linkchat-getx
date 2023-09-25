import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/room_res_model.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/room_settings_controller.dart';

class RoomSettingsView extends StatefulWidget {
  RoomSettingsView({super.key});

  @override
  State<RoomSettingsView> createState() => _RoomSettingsViewState();
}

class _RoomSettingsViewState extends State<RoomSettingsView> {
  final controller = Get.find<RoomSettingsController>();
  final RoomModel _room = Get.arguments['room'];

  @override
  void initState() {
    controller.selectedVisibility.value = _room.settings.groupVisibility;
    controller.selectedAnyoneCanAddMember.value =
        _room.settings.anyoneCanAddMember.toString();
    controller.selectedAnyoneCanModifyRoom.value =
        _room.settings.anyoneCanModifyGroup.toString();
    controller.selectedWhoCanMessage.value = _room.settings.whoCanMessage;
    controller.roomMemberCountController.text =
        _room.settings.memberLimit.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Settings'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: accentColor, size: 25),
              )
            : ListView(
                children: [
                  ListTile(
                    title: Text(
                      'Room Visibility',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Obx(
                        () => DropdownButton<String>(
                          style: Theme.of(context).textTheme.bodyMedium,
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
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Anyone can add member',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Obx(
                        () => DropdownButton<String>(
                          style: Theme.of(context).textTheme.bodyMedium,
                          value: controller.selectedAnyoneCanAddMember.value,
                          onChanged: (newValue) {
                            controller.selectedAnyoneCanAddMember.value =
                                newValue!;
                          },
                          items: controller.anyoneCanAddMemberItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Anyone can modify room',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Obx(
                        () => DropdownButton<String>(
                          style: Theme.of(context).textTheme.bodyMedium,
                          value: controller.selectedAnyoneCanModifyRoom.value,
                          onChanged: (newValue) {
                            controller.selectedAnyoneCanModifyRoom.value =
                                newValue!;
                          },
                          items: controller.anyoneCanModifyRoomItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Who can message',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Obx(
                        () => DropdownButton<String>(
                          style: Theme.of(context).textTheme.bodyMedium,
                          value: controller.selectedWhoCanMessage.value,
                          onChanged: (newValue) {
                            controller.selectedWhoCanMessage.value = newValue!;
                          },
                          items: controller.whoCanMessageItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        'Member limit',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          controller: controller.roomMemberCountController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      )),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: accentColor,
          onPressed: () => controller.updateRoomSettings(_room.id),
          label: Text(
            'Update',
            style: Theme.of(context).textTheme.labelMedium,
          )),
    );
  }
}
