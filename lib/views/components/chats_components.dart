import 'package:chat_withmoxi/consts/colors.dart';
import 'package:chat_withmoxi/consts/images.dart';
import 'package:chat_withmoxi/services/store_services.dart';
import 'package:chat_withmoxi/views/chat_screen/components/chat.dart';
import 'package:chat_withmoxi/views/home_screen/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

Widget chatsComponents(){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: StreamBuilder(
      stream: StoreServices.getMessages(),
      //edit the msg
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            bgColor
          ),
          ),
        );
      }else if(snapshot.data!.docs.isEmpty){
        return Center(
          child: "Start a Conversation".text.make(),
        );
      }else{
       return ListView(
         children: snapshot.data!.docs.mapIndexed((currentValue, index) {
           //covert each msg to variable for easy access
           var doc = snapshot.data!.docs[index];
return messageBubble(doc);
         }).toList(),
       );
      }
    },

    )
  );
}