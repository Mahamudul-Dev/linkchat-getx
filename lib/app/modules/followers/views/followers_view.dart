import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/utils/app_strings.dart';
import 'package:linkchat/app/modules/followers/views/follower_list_tile_view.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../style/style.dart';
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
        body: FutureBuilder(
          future: controller.getFollowers(),
          builder: (context, AsyncSnapshot<List<FollowerModel>> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FollowerListTileView(
                    serverId: snapshot.data![index].sId!,
                    userName: snapshot.data![index].userName!,
                    profilePic: snapshot.data![index].profilePic!,
                    uid: snapshot.data![index].uid.toString(),
                    isActive: snapshot.data![index].isActive!,
                    isChat: isChat,
                  );
                },
              );
            }
            if(snapshot.hasError){
              return Center(
                  child: Text('There are some error, please try again & check your network',
                      style: Theme.of(context).textTheme.bodyMedium));
            }
            if(snapshot.data == null){
              return Center(
                  child: Text(NO_FOLLOWERS_TEXT,
                      style: Theme.of(context).textTheme.bodyMedium));
            }

            return Obx(() {
              return controller.isLoading.value
                  ? Container(
                color: ThemeProvider().isSavedLightMood().value ? brightWhite : solidMate,
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: accentColor, size: 50.w),
                ),
              )
                  : const SizedBox.shrink();
            });

          },
        ));
  }
}
