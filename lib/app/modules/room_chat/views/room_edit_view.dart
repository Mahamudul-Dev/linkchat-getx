import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/widgets/views/edit_text_field_view.dart';

import '../../../data/models/room_res_model.dart';
import '../../../style/style.dart';
import '../controllers/room_settings_controller.dart';


class RoomEditView extends GetView<RoomSettingsController> {
  RoomEditView({super.key});

  final RoomModel room = Get.arguments['room'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Edit'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Row(
            children: [
              SizedBox(
                height: 80.h,
                width: 80.w,
                child: Image(image: CachedNetworkImageProvider(room.groupImage ?? PLACEHOLDER_IMAGE), fit: BoxFit.cover,),
              ),

              const SizedBox(width: 20,),

              Expanded(child: EditTextFieldView(iconData: Icons.groups_outlined, hintText: 'Room Name', controller: controller.roomNameController,))
            ],
          ),

          const SizedBox(height: 35,),
          Row(
            children: [
              Text('Room Description', style: Theme.of(context).textTheme.labelMedium,)
            ],
          ),
          const SizedBox(height: 15,),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.3,

            decoration: const BoxDecoration(
              color: blackAccent,
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),

            child: Expanded(child: TextField(
              decoration: InputDecoration(
                hintText: 'Room Description',
                
              ),
            )),
          )

        ],
      )
    );
  }
}
