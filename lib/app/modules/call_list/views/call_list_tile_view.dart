import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../modules/call_list/controllers/call_list_controller.dart';
import '../../../modules/call_list/views/call_menu_button_view.dart';
import '../../../style/style.dart';

class CallListTileView extends GetView<CallListController> {
  const CallListTileView(
      {Key? key,
      required this.serverId,
      required this.userName,
      required this.profilePic,
      required this.uid,
      required this.isActive,
      required this.endTime})
      : super(key: key);
  final String serverId;
  final String userName;
  final String profilePic;
  final String uid;
  final bool isActive;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ThemeProvider().isSavedLightMood().value
                    ? brightWhite
                    : black,
                backgroundImage: CachedNetworkImageProvider(profilePic),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.green : null,
                  ),
                ),
              )
            ],
          ),
        ),
        title: Text(
          userName,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Row(
          children: [
            Text(
              timeago.format(DateTime.parse(endTime)),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text('||'),
            const SizedBox(
              width: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.call_made_rounded,
                  color: accentColor,
                  size: 15,
                ),
                Text('Outgoing Call',
                    style: TextStyle(color: accentColor, fontSize: 10.sp))
              ],
            )
          ],
        ),
        trailing: CallMenuButtonView(serverId: serverId));
  }

// Widget getStatus(int index) {
//   if (controller.callHistory[index].isComplete &&
//       controller.callHistory[index].callerId == DatabaseHelper().getUserData().data?.first.uid) {
//     return Row(
//       children: [
//         const Icon(
//           Icons.call_made_rounded,
//           color: accentColor,
//           size: 15,
//         ),
//         Text('Outgoing Call',
//             style: TextStyle(color: accentColor, fontSize: 10.sp))
//       ],
//     );
//   } else if (!controller.callHistory[index].isComplete &&
//       controller.callHistory[index].receiverId == DatabaseHelper().getUserData().data?.first.uid) {
//     return Row(
//       children: [
//         const Icon(
//           Icons.call_received_rounded,
//           color: Colors.green,
//           size: 20,
//         ),
//         Text('Incomming Call',
//             style: TextStyle(color: Colors.green, fontSize: 14.sp))
//       ],
//     );
//   } else if (controller.callHistory[index].isComplete &&
//       controller.callHistory[index].callerId == DatabaseHelper().getUserData().data?.first.uid) {
//     return Row(
//       children: [
//         const Icon(
//           Icons.call_missed_outgoing,
//           color: accentColor,
//           size: 20,
//         ),
//         Text('Missed Call',
//             style: TextStyle(color: Colors.red, fontSize: 14.sp))
//       ],
//     );
//   } else {
//     return Row(
//       children: [
//         const Icon(Icons.call_missed, color: accentColor),
//         Text('Missed Call',
//             style: TextStyle(color: Colors.red, fontSize: 14.sp))
//       ],
//     );
//   }
// }
}
