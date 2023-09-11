import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';

class RoomCard extends StatelessWidget {
  const RoomCard(
      {super.key,
      required this.roomPhoto,
      required this.roomName,
      required this.participantCount,
      this.onlineParticipantCount});

  final String roomPhoto;
  final String roomName;
  final int participantCount;
  final int? onlineParticipantCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
