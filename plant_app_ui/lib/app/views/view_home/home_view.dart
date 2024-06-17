import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/widgets/side_bar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: const Stack(
            children: [
              Row(
                children: [SideBar()],
              ),
            ],
          )),
    );
  }
}
