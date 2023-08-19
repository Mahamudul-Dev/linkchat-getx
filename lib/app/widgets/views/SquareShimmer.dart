import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../style/style.dart';

class SquareShimmer extends StatelessWidget {
  const SquareShimmer({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 3),
      height: height,
      child: Shimmer.fromColors(
        period: const Duration(seconds: 5),
        baseColor: transparentBlack,
        highlightColor: darkAsh,
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: solidMate),
        ),
      ),
    );
  }
}
