import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import '../../../data/models/room_res_model.dart';
import '../../../style/style.dart';
import '../../../widgets/views/SquareShimmer.dart';
import '../../room_chat/views/room_card.dart';
import '../controllers/room_explor_controller.dart';

class RoomExploreView extends GetView<RoomExplorController> {
  const RoomExploreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Rooms'),
        centerTitle: false,
      ),
      body: FutureBuilder(
          future: controller.getPublicRooms(),
          builder: (context, AsyncSnapshot<RoomResModel> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data?.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return RoomCard(
                      onTap: () => snapshot.data!.data[index].members
                              .contains(AccountHelper.getUserData().serverId)
                          ? Get.toNamed(Routes.ROOM_CONVERSATION,
                              arguments: {'room': snapshot.data?.data[index]})
                          : controller
                              .joinRoom(snapshot.data!.data[index].joinCode),
                      buttonText: snapshot.data!.data[index].members.contains(AccountHelper.getUserData().serverId)
                          ? 'View'
                          : 'Join',
                      memberLimit:
                          snapshot.data?.data[index].settings.memberLimit ?? 0,
                      nudeProtection:
                          snapshot.data?.data[index].settings.nudeProtection ?? false
                              ? 'Enabled'
                              : 'Deactivated',
                      joiningCode: snapshot.data?.data[index].joinCode ?? 0,
                      whoCanMessage: snapshot.data?.data[index].settings.whoCanMessage ??
                          'Everyone',
                      roomPhoto: snapshot.data?.data[index].groupImage != null
                          ? '$BASE_URL${snapshot.data?.data[index].groupImage}'
                          : PLACEHOLDER_IMAGE,
                      roomName: snapshot.data?.data[index].groupName ?? 'Unknown',
                      participantCount: snapshot.data?.data[index].members.length ?? 0,
                      onlineParticipantCount: 788);
                },
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 55,
              itemBuilder: (BuildContext context, int index) {
                return const SquareShimmer(height: 170, width: 130);
              },
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  decoration: const BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Type Room Pin',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        // Pinput(
                        //   length: 7,
                        //   onCompleted: (value) {},
                        //   defaultPinTheme: PinTheme(
                        //     width: 55,
                        //     height: 55,
                        //     textStyle: TextStyle(
                        //         fontSize: 20.sp,
                        //         color: accentColor,
                        //         fontWeight: FontWeight.w600),
                        //     decoration: BoxDecoration(
                        //       color: ThemeProvider().isSavedLightMood().value
                        //           ? white
                        //           : darkAsh,
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: EditTextFieldView(
                            iconData: Icons.password_rounded,
                            controller: controller.joiningPinController,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Ask the room admin for getting room pin',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () => controller.joinRoom(int.parse(
                                controller.joiningPinController.text)),
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(accentColor)),
                            child: Text(
                              'Join',
                              style: Theme.of(context).textTheme.labelMedium,
                            ))
                      ],
                    ),
                  ),
                );
              });
        },
        label: const Row(
          children: [
            Text(
              'Joining Code',
              style: TextStyle(color: brightWhite, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.password)
          ],
        ),
        backgroundColor: accentColor,
      ),
    );
  }
}
