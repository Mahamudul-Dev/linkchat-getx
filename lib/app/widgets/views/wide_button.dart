import 'package:flutter/material.dart';
import '../../style/style.dart';

class WideButton extends StatelessWidget {

  final String buttonText;
  final String buttonIcon;
  final Color buttonColor;
  final void Function()? onTap;

  const WideButton({super.key, required this.buttonText, required this.buttonIcon, required this.buttonColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(image: AssetImage(buttonIcon), fit: BoxFit.cover, height: 30, width: 30,),
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}