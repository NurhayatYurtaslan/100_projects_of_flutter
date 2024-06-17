import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/widgets/body_widget.dart';
import 'package:plant_app_ui/core/widgets/side_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Row(
          children: [
            SideBar(),
            BodyWidget(),
          ],
        ),
        Positioned(
          top: 100,
          left: 29,
          child: Text(
            "Plants",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        Positioned(
          top: 45,
          right: 10,
          child: Icon(
            Icons.search,
            color: Colors.black,
            size: 40,
          ),
        ),
      ],
    ));
  }
}


