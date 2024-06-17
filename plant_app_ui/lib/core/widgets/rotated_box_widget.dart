import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/constants/color_constants.dart';

class RotatedBoxWidget extends StatelessWidget {
  final String widgetText;
  final bool indexController;
  const RotatedBoxWidget({
    super.key,
    required this.widgetText,
    required this.indexController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: RotatedBox(
        quarterTurns: 3,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: ".",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: indexController ? secondaryColor : primaryColor),
          ),
          TextSpan(
              text: widgetText,
              style: TextStyle(
                  color: indexController ? blackColor : primaryColor)),
        ])),
      ),
    );
  }
}
