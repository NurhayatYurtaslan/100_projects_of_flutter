import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/constants/color_constants.dart';
import 'package:plant_app_ui/core/extensions/context_extension.dart';
import 'package:plant_app_ui/core/widgets/rotated_box_widget.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Sola hizalamak için eklendi
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Image.asset(
              "assets/icons/more icon.png",
              width: MediaQuery.of(context).size.width / 6,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Green",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left, // Sola hizalamak için eklendi
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(height: context.constMediumValue * 4),
          const RotatedBoxWidget(
            widgetText: 'Shape Close',
            indexController: false,
          ),
          const SizedBox(height: 30),
          const RotatedBoxWidget(
            widgetText: 'Indoor Plants',
            indexController: true,
          ),
          const SizedBox(height: 30),
          const RotatedBoxWidget(
            widgetText: 'Green Plants',
            indexController: true,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: primaryColor,
                  ),
                  width: 60,
                  height: 70,
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
