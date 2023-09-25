import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/room_res_model.dart';
import '../../../style/style.dart';
import '../controllers/room_settings_controller.dart';

class RoomEditView extends StatefulWidget {
  RoomEditView({super.key});

  @override
  State<RoomEditView> createState() => _RoomEditViewState();
}

class _RoomEditViewState extends State<RoomEditView> {
  final RoomModel room = Get.arguments['room'];
  final controller = Get.find<RoomSettingsController>();

  @override
  void initState() {
    controller.roomNameController.text = room.groupName;
    controller.roomDescriptionController.text = room.groupDescription;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Edit'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: accentColor, size: 25),
              )
            : ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: SizedBox(
                                  height: 80.h,
                                  width: 80.w,
                                  child: Obx(() =>
                                      controller.groupImageFile.value != null
                                          ? Image(
                                              image: FileImage(controller
                                                  .groupImageFile.value!),
                                              fit: BoxFit.cover,
                                            )
                                          : Image(
                                              image: CachedNetworkImageProvider(
                                                  room.groupImage == 'N/A'
                                                      ? PLACEHOLDER_IMAGE
                                                      : '$BASE_URL${room.groupImage}'),
                                              fit: BoxFit.cover,
                                            ))),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 3,
                              child: IconButton(
                                  onPressed: () => controller.pickImage(),
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: accentColor,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: EditTextFieldView(
                        iconData: Icons.groups_outlined,
                        hintText: 'Room Name',
                        controller: controller.roomNameController,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text(
                        'Room Description',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                        color: blackAccent,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Expanded(
                        child: TextField(
                      maxLines: null,
                      maxLength: 200,
                      controller: controller.roomDescriptionController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          hintText: 'Room Description',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: InputBorder.none),
                    )),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await controller.updateRoomInfo(room);
        },
        backgroundColor: accentColor,
        label: Text(
          'Update',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
