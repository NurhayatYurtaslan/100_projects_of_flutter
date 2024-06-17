import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/constants/color_constants.dart';
import 'package:plant_app_ui/core/widgets/rotated_box_widget.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: secondaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Image.asset(
              "assets/icons/more icon.png",
              width: MediaQuery.of(context).size.width / 3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Green",
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "PLANTS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const RotatedBoxWidget(
            widgetText: 'Shape Close',
            indexController: false,
          ),
          const SizedBox(
            height: 10,
          ),
          const RotatedBoxWidget(
            widgetText: 'Indoor Plants',
            indexController: true,
          ),
          const SizedBox(
            height: 40,
          ),
          const RotatedBoxWidget(
            widgetText: 'Green Plants',
            indexController: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 110),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: primaryColor),
              width: 60,
              height: 70,
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
