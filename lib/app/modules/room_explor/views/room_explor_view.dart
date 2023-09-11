import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:pinput/pinput.dart';

import '../../../style/style.dart';
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 55,
        itemBuilder: (BuildContext context, int index) {
          return const RoomCard(
            roomPhoto: PLACEHOLDER_IMAGE,
            roomName: 'Alu Bazar.com',
            participantCount: 89985,
            onlineParticipantCount: 15551,
          );
        },
      ),
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
                        Pinput(
                          length: 5,
                          onCompleted: (value) {},
                          defaultPinTheme: PinTheme(
                            width: 55,
                            height: 55,
                            textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: accentColor,
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              color: ThemeProvider().isSavedLightMood().value
                                  ? white
                                  : darkAsh,
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                            onPressed: () {},
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
