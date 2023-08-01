import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../style/style.dart';

class CircularShimmer extends StatelessWidget {
  const CircularShimmer({super.key, this.height, this.width, this.radius});
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 55,
      height: height ?? 55,
      child: Shimmer.fromColors(
        period: const Duration(seconds: 5),
        baseColor: transparentBlack,
        highlightColor: darkAsh,
        child: CircleAvatar(
          radius: radius ?? 30,
          backgroundColor: solidMate,
        ),
      ),
    );
  }
}
