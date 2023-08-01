import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: darkAsh,
                backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
              ),
              title: Text(
                'Bill Gates',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: Text(
                'Send followed you. You can link him now',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
        ));
  }
}
