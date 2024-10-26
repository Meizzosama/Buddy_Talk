

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/strings.dart';

Widget tabbar(){
  return Container(
    child:const RotatedBox(quarterTurns: 1,
    child:
    TabBar(
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: Vx.gray500,
      indicator: BoxDecoration(),
      tabs: [
        Text(chats),
        Text(status),
        Text(camera),

      ],
    ),
    ), );
}