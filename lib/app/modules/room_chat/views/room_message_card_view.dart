import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/database/helpers/helpers.dart';
import 'package:linkchat/app/database/room_schema.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:linkchat/app/style/app_color.dart';

import 'package:mime/mime.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/models/room_conversation_model.dart';

class RoomMessageCardView extends GetView {
  const RoomMessageCardView({super.key, required this.message});

  final RoomMessageSchema message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.senderId == AccountHelper.getUserData().serverId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              message.senderId == AccountHelper.getUserData().serverId
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        message.senderId == AccountHelper.getUserData().serverId
                            ? accentColor
                            : blackAccent),
                child: ReadMoreText(
                  message.message ?? '',
                  trimLines: 10,
                  colorClickableText: brightWhite,
                  trimMode: TrimMode.Line,
                  style: Theme.of(context).textTheme.bodyMedium,
                  trimCollapsedText: '  Show more',
                  trimExpandedText: '  Show less',
                  moreStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  lessStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Text(
                //   timeago.format(DateTime.parse(message.createdAt!)),
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodySmall
                //       ?.copyWith(color: Colors.grey),
                // ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.send_rounded,
                  color: Colors.grey,
                  size: 10,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildMediaMessage(String filepath, BuildContext context) {
    final fileType = lookupMimeType(path.extension(filepath));
    Logger().i(fileType);
    //final player = Player();
    if (fileType!.startsWith('/image')) {
      return Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 200,
        child: Image(
          image: FileImage(File(filepath)),
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 200,
      );
    }
  }
}
