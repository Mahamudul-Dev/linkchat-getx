import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/modules/message/controllers/message_controller.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:readmore/readmore.dart';

import '../../../database/conversatin_schema.dart';

class TextMessage extends GetView<MessageController> {
  const TextMessage({super.key, required this.message});

  final MessageSchema message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: controller.isOwnMessage(message)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: controller.isOwnMessage(message)
                    ? accentColor
                    : blackAccent),
            child: ReadMoreText(
              message.content,
              trimLines: 10,
              colorClickableText: brightWhite,
              trimMode: TrimMode.Line,
              style: Theme.of(context).textTheme.bodyMedium,
              trimCollapsedText: '  Show more',
              trimExpandedText: '  Show less',
              moreStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              lessStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
