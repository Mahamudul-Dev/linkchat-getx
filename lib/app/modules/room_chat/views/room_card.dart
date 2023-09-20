import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';

import '../../../style/style.dart';

class RoomCard extends StatelessWidget {
  const RoomCard(
      {super.key,
      required this.roomPhoto,
      required this.roomName,
      required this.memberLimit,
      required this.nudeProtection,
      required this.joiningCode,
      required this.whoCanMessage,
      required this.buttonText,
      required this.participantCount,
      this.onlineParticipantCount,
      this.onTap});

  final String roomPhoto;
  final String roomName;
  final int memberLimit;
  final String nudeProtection;
  final int joiningCode;
  final String whoCanMessage;
  final String buttonText;
  final int participantCount;
  final int? onlineParticipantCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 500,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: blackAccent),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image(
                                  image: CachedNetworkImageProvider(roomPhoto),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    roomName,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Details:',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Member Limit :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                memberLimit.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Nude Protection :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                nudeProtection,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Joining Code :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                joiningCode.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                'Who Can Message :',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                whoCanMessage,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      accentColor)),
                                          onPressed: onTap,
                                          child: Text(
                                            buttonText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                });
          },
          child: Container(
            width: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: CachedNetworkImageProvider(roomPhoto),
                      fit: BoxFit.fill,
                    )),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 130,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0), // Faded black
                          Colors.black, // Bold black
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${ProfileController().formatNumber(onlineParticipantCount ?? 0)} online',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 3,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roomName,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Participants: ${ProfileController().formatNumber(participantCount)}',
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
