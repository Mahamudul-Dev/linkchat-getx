import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkchat/app/data/models/models.dart';
import 'package:linkchat/app/data/models/multiple_profile_req_model.dart';
import 'package:linkchat/app/data/models/room_res_model.dart';
import 'package:linkchat/app/services/api_service.dart';
import 'package:linkchat/app/widgets/views/CircullarShimmer.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/utils/utils.dart';
import '../../../style/style.dart';

class RoomChatTile extends StatelessWidget {
  const RoomChatTile({super.key, required this.room});

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: blackAccent,
                backgroundImage: CachedNetworkImageProvider(
                    room.groupImage ?? PLACEHOLDER_IMAGE),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        room.groupName,
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(room.groupDescription,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    child: Center(
                        child: FutureBuilder(
                            future: ApiService.getMultipleProfile(
                                GetMultipleProfileReqModel(
                                    idList: room.members)),
                            builder: (context,
                                AsyncSnapshot<GetMultipleProfileModel?>
                                    snapshot) {
                              Logger().i(snapshot.hasData);
                              if (snapshot.hasData) {
                                if (snapshot.data!.profiles.isNotEmpty) {
                                  return ListView.separated(
                                      itemBuilder: (context, index) {
                                        if (index == 5) {
                                          return CircleAvatar(
                                            radius: 10,
                                            backgroundColor: blackAccent,
                                            child: Center(
                                              child: Text(
                                                '${index - 5}+',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return CircleAvatar(
                                            radius: 10,
                                            backgroundColor: blackAccent,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    snapshot
                                                        .data!
                                                        .profiles[index]
                                                        .profilePic),
                                          );
                                        }
                                      },
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 3),
                                      itemCount:
                                          snapshot.data!.profiles.length);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }
                              return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return const CircularShimmer();
                                  },
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 3),
                                  itemCount: 5);
                            })),
                  )
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                timeago.format(DateTime.now()),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: accentColor),
                child: Center(
                  child: Text(
                    '16',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
