import 'package:flutter/material.dart';
import 'package:travel_app/app/views/view_destination/destination_view.dart';
import 'package:travel_app/core/constants/color_constants.dart';

class HotDestinationItemsWidget extends StatelessWidget {
  const HotDestinationItemsWidget({
    super.key,
    required this.image,
    required this.name,
    required this.noOfTourism,
    required this.context,
  });

  final String image;
  final String name;
  final String noOfTourism;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotDestination(image, name),
          ),
        );
      },
      child: Stack(
        children: [
          // for image
          Hero(
            tag: image,
            child: Container(
              height: 220,
              width: 150,
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // for image shadow,
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 220,
              width: 150,
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
          ),
          // for name and more
          Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: primaryColor.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    noOfTourism,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      color: Colors.white30,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}