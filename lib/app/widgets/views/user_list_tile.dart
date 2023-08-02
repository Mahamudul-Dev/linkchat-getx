// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:logger/logger.dart';

class UserListTile extends StatefulWidget {
  UserListTile(
      {super.key,
      this.userName,
      this.email,
      this.country,
      this.profilePic,
      this.isActive = false,
      required this.onPresses,
      required this.buttonStatus});

  final String? profilePic;
  final String? userName;
  final String? email;
  final String? country;
  final bool isActive;
  Future<String> buttonStatus;
  final Future<String> Function() onPresses;

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
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
              backgroundColor: blackAccent,
              backgroundImage: CachedNetworkImageProvider(
                  widget.profilePic ?? PLACEHOLDER_IMAGE),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 13,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isActive ? Colors.green : null,
                ),
              ),
            )
          ],
        ),
      ),
      title: Text(
        widget.userName ?? '',
        style: Theme.of(context).textTheme.labelMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.country ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: ElevatedButton(
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
              })),
    );
  }
}
