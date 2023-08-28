// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import 'package:linkchat/app/widgets/views/SquareShimmer.dart';
import 'package:logger/logger.dart';

import '../../../style/style.dart';
import '../../search/controllers/search_controller.dart';

class AboutCardView extends GetView<ProfileController> {
  const AboutCardView({Key? key, required this.sId}) : super(key: key);
  final String sId;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: sId == controller.getCurrentProfile.serverId
            ? _buildOwnAbout(controller, context)
            : _buildOtherAbout(sId, controller, context));
  }
}

// own about tab
Widget _buildOwnAbout(ProfileController controller, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Bio',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      const SizedBox(
        height: 3,
      ),
      Text(
        controller.getCurrentProfile.bio ?? 'No Information Available',
        textAlign: TextAlign.justify,
        style: TextStyle(
            color:
                ThemeProvider().isSavedLightMood().value ? black : brightWhite),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget _buildOtherAbout(
    String sId, ProfileController controller, BuildContext context) {
  return FutureBuilder(
      future: controller.getProfileDetails(sId),
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bio',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                controller.getCurrentProfile.bio ?? 'No Information Available',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: ThemeProvider().isSavedLightMood().value
                        ? black
                        : brightWhite),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RequestButton(
                      onPresses: () => Get.find<SearchViewController>()
                          .handleFollow(
                              sId, snapshot.data?.data.first.userName ?? ''),
                      buttonStatus: Get.find<SearchViewController>()
                          .getButtonStatus(sId)),
                  FutureBuilder(
                    future: controller.checkLinked(sId),
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!
                            ? ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(accentColor)),
                                onPressed: () {},
                                child: const Text('Chat',
                                    style: TextStyle(
                                        color: brightWhite,
                                        fontWeight: FontWeight.w600)))
                            : const SizedBox.shrink();
                      }
                      return SquareShimmer(height: 45, width: 60);
                    },
                  )
                ],
              )
            ],
          );
        }

        return SquareShimmer(
            height: 100, width: MediaQuery.of(context).size.width * 0.9);
      });
}

class RequestButton extends StatefulWidget {
  RequestButton(
      {super.key, required this.onPresses, required this.buttonStatus});

  final Future<String> Function() onPresses;
  Future<String> buttonStatus;

  @override
  State<RequestButton> createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.onPresses().then((value) {
            setState(() {
              widget.buttonStatus = Future.value(value);
            });
          }).catchError((err) {
            Logger().e(err);
          });
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(accentColor)),
        child: FutureBuilder(
            future: widget.buttonStatus,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: Theme.of(context).textTheme.labelSmall,
                );
              }
              return const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: brightWhite,
                    strokeWidth: 3,
                  ));
            }));
  }
}
