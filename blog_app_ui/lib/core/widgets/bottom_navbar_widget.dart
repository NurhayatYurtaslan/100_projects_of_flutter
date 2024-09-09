import 'package:flutter/material.dart';

Widget bottomNavBarItems(IconData icon, {bool isSelected = false}) {
  return GestureDetector(
    onTap: () {},
    child: Icon(
      icon,
      size: 30,
      color: isSelected ? Colors.blue : Colors.black87,
    ),
  );
}