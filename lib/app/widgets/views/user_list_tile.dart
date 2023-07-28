import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.userName, this.email, required this.country, this.profilePic, this.isActive = false, this.onPresses, required this.buttonStatus});

  final String? profilePic;
  final String userName;
  final String? email;
  final String country;
  final bool isActive;
  final RxString buttonStatus;
  final void Function()? onPresses;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:blackAccent,
              backgroundImage: CachedNetworkImageProvider(profilePic ?? PLACEHOLDER_IMAGE),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 13,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? Colors.green
                      : null,
                ),
              ),
            )
          ],
        ),
      ),
      title: Text(userName, style: Theme.of(context).textTheme.labelMedium, overflow: TextOverflow.ellipsis,),
      subtitle: Text(email ?? '', style: Theme.of(context).textTheme.bodyMedium,),
      trailing: ElevatedButton(onPressed: onPresses, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(accentColor)), child: Obx(() => Text(buttonStatus.value, style: Theme.of(context).textTheme.labelSmall,))),
    );
  }
}
