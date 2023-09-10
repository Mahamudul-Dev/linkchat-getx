import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/utils/utils.dart';
import '../../../style/style.dart';

class RoomChatTile extends StatelessWidget {
  const RoomChatTile({super.key, required this.roomName, required this.roomDesc});

  final String roomName;
  final String roomDesc;

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
              const CircleAvatar(
                radius: 25,
                backgroundColor: blackAccent,
                backgroundImage:
                CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        'Freelancers Bangladesh',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                          'Official freelancers group of bangladesh',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    child: Center(
                        child: ListView.separated(
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
                                return const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: blackAccent,
                                  backgroundImage: CachedNetworkImageProvider(
                                      PLACEHOLDER_IMAGE),
                                );
                              }
                            },
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                            const SizedBox(width: 3),
                            itemCount: 6)
                    ),
                  )
                ],
              )
            ],
          )
          ,Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(timeago.format(DateTime.now()), style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: 3,),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor
                ),
                child: Center(
                  child: Text('16', style: Theme.of(context).textTheme.bodySmall,),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
