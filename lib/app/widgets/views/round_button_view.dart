import 'package:flutter/material.dart';

import 'package:linkchat/app/style/app_color.dart';
import 'package:get/get.dart';

class RoundButtonView extends GetView {
  const RoundButtonView(
      {Key? key, this.onTap, this.icon, this.iconSize, this.widget})
      : super(key: key);
  final void Function()? onTap;
  final IconData? icon;
  final double? iconSize;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor,
        ),
        child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: brightWhite,
                    size: iconSize,
                  )
                : widget),
      ),
    );
  }
}
