import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/followers/views/follower_list_tile_view.dart';
import 'package:linkchat/app/widgets/widgets.dart';

import '../controllers/followers_controller.dart';

class FollowersView extends GetView<FollowersController> {
  FollowersView({Key? key}) : super(key: key);
  final bool isChat = Get.arguments['isChat'] ?? false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
        bottom: const SearchBarView(
          height: 45,
          hint: 'Search followers...',
        ),
      ),
      body: ListView.builder(
        itemCount: controller.followers.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return FollowerListTileView(index: index, isChat: isChat);
        },
      ),
    );
  }
}
