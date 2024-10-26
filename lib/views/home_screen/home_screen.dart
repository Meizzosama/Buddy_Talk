



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/controllers/home_controller.dart';
import '../components/appbar.dart';
import '../components/drawers.dart';
import '../components/tabbar.dart';
import '../components/tabbarview.dart';
import '../compose_screen/components/compose_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
//init home controller
    var controller = Get.put(HomeController());

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldkey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white38,
            onPressed: () {
              //goto Compose Screen
              Get.to(() => const ComposeScreen(),
                  transition: Transition.downToUp);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          backgroundColor: bgColor,
          body: Column(
            children: [
              appbar(scaffoldkey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
