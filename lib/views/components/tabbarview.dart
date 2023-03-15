import 'package:chat_withmoxi/views/components/chats_components.dart';
import 'package:chat_withmoxi/views/components/status_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';

Widget tabbarView(){
  return Expanded(child:
    Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),),
    child: TabBarView(
    children: [
      Container(
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
          ),
        child: chatsComponents(),

      ),
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
          color: Colors.white60,
        ),
        child: statusComponent(),
      ),
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
          color: Colors.tealAccent,),
      ),
    ],),),);
}