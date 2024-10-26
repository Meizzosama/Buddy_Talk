
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../consts/controllers/home_controller.dart';
import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../consts/utils.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.only(right: 12),
    height: 130,
    color: Colors.white38,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            width: 100,
            height: 130,
            child: const Icon(
              settingsIcon,
              color: Colors.white,
            ),
          ),
        ),
        RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "\n $appname \n",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: bold,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            TextSpan(
              text: "\nConnecting Lives..",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          backgroundImage: NetworkImage(HomeController.instance.userImage),
        ).box.roundedFull.clip(Clip.antiAlias).make(),
      ],
    ),
  );
}
