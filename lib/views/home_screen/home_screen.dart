import 'package:chat_withmoxi/consts/colors.dart';
import 'package:chat_withmoxi/consts/controllers/home_controller.dart';
import 'package:chat_withmoxi/views/components/drawers.dart';
import 'package:chat_withmoxi/views/components/tabbar.dart';
import 'package:chat_withmoxi/views/components/tabbarview.dart';
import 'package:chat_withmoxi/views/compose_screen/components/compose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../components/appbar.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen ({super.key,});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey=GlobalKey<ScaffoldState>();
//init home controller
    var controller = Get.put(HomeController());

return
  SafeArea(
    child:
  DefaultTabController(
  length: 3, child:
  Scaffold(

    key: scaffoldkey,
    drawer: drawer(),
  floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.white38,
    onPressed: (){
      //goto Compose Screen
      Get.to(()=>const ComposeScreen(),transition: Transition.downToUp);
    },
    child:  const Icon(Icons.add,),
  ),
  backgroundColor: bgColor,
  body: Column(
    children: [
      appbar(scaffoldkey),
    Expanded(child:
      Row(
        children: [
      tabbar(),
          tabbarView(),
        ],
      ),
    ), ],
  ),
  ),
  ),);

  }

}