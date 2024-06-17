import 'package:flutter/material.dart';
import 'package:plant_app_ui/core/extensions/context_extension.dart';
import 'package:plant_app_ui/core/widgets/product_widget.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.78,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {},
              child: const Hero(
                  tag: "flower1",
                  child: ProductWidget(
                      image: "assets/images/flower1.png",
                      name: "House Shape Close",
                      price: "45")),
            ),
            GestureDetector(
              onTap: () {},
              child: const Hero(
                  tag: "flower2",
                  child: ProductWidget(
                      image: "assets/images/flower2.png",
                      name: "Glass Water",
                      price: "60")),
            ),
          ],
        ),
      ),
    );
  }
}
