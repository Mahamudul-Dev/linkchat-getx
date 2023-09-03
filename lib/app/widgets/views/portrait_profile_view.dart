import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style/style.dart';

class PortraitProfileView extends GetView {
  const PortraitProfileView({
    super.key,
    required this.name,
    required this.photo,
    required this.location,
    required this.age,
    this.tagline,
    required this.isActive,
    required this.buttonIcon,
    required this.buttonText,
    this.buttonOnTap,
  });
  final String name;
  final String photo;
  final String location;
  final String age;
  final String? tagline;
  final bool isActive;
  final IconData buttonIcon;
  final String buttonText;
  final void Function()? buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: photo,
          progressIndicatorBuilder: (context, url, progress) =>
              CircularProgressIndicator(
            value: progress.downloaded.toDouble(),
          ),
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 400,
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
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6),
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        ', (Age $age)',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: isActive ? Colors.green : Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 18,
                      ),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  tagline != null
                      ? Column(
                          children: [
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  tagline ?? '',
                                ),
                              ],
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: buttonOnTap,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                    icon: Icon(
                      buttonIcon,
                      color: Colors.white,
                    ),
                    label: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
