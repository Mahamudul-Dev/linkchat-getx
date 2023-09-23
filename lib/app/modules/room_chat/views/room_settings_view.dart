import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/room_settings_controller.dart';


class RoomSettingsView extends GetView<RoomSettingsController> {
  const RoomSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Settings'),
      ),

      body: ListView(
        children: [
          ListTile(
            title: Text('Room Visibility', style: Theme.of(context).textTheme.labelMedium,),
            trailing: Obx(
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
            ),
          ),

          ListTile(
            title: Text('Anyone can add member', style: Theme.of(context).textTheme.labelMedium,),
            trailing: Obx(
                  () => DropdownButton<String>(
                style: Theme.of(context).textTheme.labelSmall,
                value: controller.selectedAnyoneCanAddMember.value,
                onChanged: (newValue) {
                  controller.selectedAnyoneCanAddMember.value = newValue!;
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

          ListTile(
            title: Text('Anyone can modify room', style: Theme.of(context).textTheme.labelMedium,),
            trailing: Obx(
                  () => DropdownButton<String>(
                style: Theme.of(context).textTheme.labelSmall,
                value: controller.selectedAnyoneCanModifyRoom.value,
                onChanged: (newValue) {
                  controller.selectedAnyoneCanModifyRoom.value = newValue!;
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

          ListTile(
            title: Text('Who can message', style: Theme.of(context).textTheme.labelMedium,),
            trailing: Obx(
                  () => DropdownButton<String>(
                style: Theme.of(context).textTheme.labelSmall,
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
          )
        ],
      ),

    );
  }
}
