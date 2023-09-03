import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:linkchat/app/style/app_color.dart';

class MatchProfileCard extends GetView {
  const MatchProfileCard({
    super.key,
    required this.image,
    required this.height,
    required this.name,
    required this.location,
    required this.dateOfBirth,
    required this.isActive,
    this.onTap,
  });

  final String image;
  final double height;
  final String name;
  final String location;
  final String dateOfBirth;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: height,
                child: Image(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0), // Faded black
                      Colors.black, // Bold black
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(shadows: [
                                  const Shadow(
                                    offset: Offset(2.0, 2.0),
                                    color: Colors.black,
                                    blurRadius: 7.0,
                                  )
                                ]),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                dateOfBirth,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    isActive ? Colors.green : Colors.red,
                              )
                            ],
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: white,
                            size: 10,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            location,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
