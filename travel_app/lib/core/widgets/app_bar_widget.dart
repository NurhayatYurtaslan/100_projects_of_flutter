import 'package:flutter/material.dart';
import 'package:travel_app/core/constants/color_constants.dart';

Padding myAppBar() {
    return const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 20,
                  left: 20,
                  bottom: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Destination",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 35,
                        color: primaryColor,
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white12,
                      child: Icon(
                        Icons.search,
                        color: Colors.white38,
                        size: 30,
                      ),
                    )
                  ],
                ),
              );
  }