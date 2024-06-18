  import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';

Widget scrollableImage(BuildContext context, String image) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.only(
            right: 20,
          ),
          width: size.width / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Opacity(
              opacity: 1.0,
              child: Container(
                height: 220,
                width: size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      secondaryColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }