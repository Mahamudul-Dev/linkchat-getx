import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/asset_manager.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:linkchat/app/widgets/views/match_profile_card.dart';
import 'package:linkchat/app/widgets/views/portrait_profile_view.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/match_model.dart';
import '../../../data/utils/utils.dart';
import '../../../database/helpers/helpers.dart';
import '../controllers/match_controller.dart';

class MatchView extends GetView<MatchController> {
  const MatchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Match'),
              SizedBox(width: 8),
              Icon(CupertinoIcons.heart_circle_fill)
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(9),
              child: CircleAvatar(
                radius: 35.w,
                backgroundColor: darkAsh,
                backgroundImage: CachedNetworkImageProvider(
                    AccountHelper.getUserData().photo ?? PLACEHOLDER_IMAGE),
              ),
            )
          ],
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.getMatches(),
            builder: (context, AsyncSnapshot<MatchModel> snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data!.data.isNotEmpty){
                  return MasonryGridView.builder(
                      itemCount: snapshot.data?.data.length,
                      gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return MatchProfileCard(
                          image: snapshot.data?.data[index].profilePic == 'N/A'
                              ? PLACEHOLDER_IMAGE
                              : snapshot.data?.data[index].profilePic ??
                              PLACEHOLDER_IMAGE,
                          height: index % 2 == 1 ? 200 : 170,
                          name:
                          '${controller.nameSpaceBreaker(snapshot.data?.data[index].userName ?? 'Unknown')}, ',
                          dateOfBirth: controller.calculateAge('1999-11-29'),
                          location: snapshot.data?.data[index].country ?? 'Unknown',
                          isActive: snapshot.data?.data[index].isActive ?? false,
                          onTap: () {
                            showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return PortraitProfileView(
                                      name: snapshot.data?.data[index].userName ??
                                          'Unknown',
                                      photo: snapshot.data?.data[index].profilePic ==
                                          'N/A'
                                          ? PLACEHOLDER_IMAGE
                                          : snapshot.data?.data[index].profilePic ??
                                          PLACEHOLDER_IMAGE,
                                      location: snapshot.data?.data[index].country ??
                                          'Unknown',
                                      age: '19',
                                      tagline: snapshot.data?.data[index].tagLine,
                                      isActive: true,
                                      buttonIcon: CupertinoIcons.heart,
                                      buttonText: 'Match',
                                      buttonOnTap: () {
                                        _showLottieAnimationDialog(context);
                                        Timer(const Duration(seconds: 1), () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        });
                                      });
                                });
                          },
                        );
                      });
                } else {
                  return Center(
                    child: Text(snapshot.data!.message, style: Theme.of(context).textTheme.bodyMedium,),
                  );
                }
              }else{
                return MasonryGridView.builder(
                    itemCount: 20,
                    gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: SquareShimmer(
                          height: index % 2 == 1 ? 150 : 120,
                          width: double.maxFinite,
                        ),
                      );
                    });
              }
            }));
  }

  void _showLottieAnimationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: Lottie.asset(
              AssetManager
                  .HEART_ANIM, // Replace with your Lottie animation file path
              width: 150, // Adjust the width and height as needed
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
