import 'package:chat_withmoxi/consts/consts.dart';
import 'package:chat_withmoxi/consts/images.dart';
import 'package:chat_withmoxi/consts/strings.dart';
import 'package:chat_withmoxi/main.dart';
import 'package:chat_withmoxi/views/chat_screen/components/chat.dart';
import 'package:chat_withmoxi/views/profile_screen/componensts/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/controllers/home_controller.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: Colors.lightBlueAccent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onTap: () {
                Get.back();
              },
              title: settings.text.size(20).black.bold.make(),
            ),
            15.heightBox,
            CircleAvatar(
              backgroundImage: NetworkImage(HomeController.instance.userImage),
              radius: 45,
            ),
            15.heightBox,
            HomeController.instance.username.text.black.fontFamily(bold).size(16).make(),
            const Divider(
              color: Colors.blueGrey,
              height: 1,
            ),
            15.heightBox,
            ListView(
              shrinkWrap: true,
              children: List.generate(
                drawerIconsList.length,
                (index) => ListTile(
                  title: Text(
                    drawerListTitles[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(drawerIconsList[index]),
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.to(() => const ProfileScreen(),
                            transition: Transition.downToUp);
                    }
                  },
                ),
              ),
            ),
            10.heightBox,
            const Divider(
              color: Colors.transparent,
              height: 1,
            ),
            25.heightBox,
            ListTile(
                leading: (Image.asset(
                  invites,
                  height: 45,
                )),
                onTap: () {},
                title: const Text(
                  "Invite a Friend",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            Spacer(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onTap: () async {
                await auth.signOut();
                Get.offAll(() => ChatApp());
              },
              title: logout.text.bold.size(16).make(),
            ),
          ],
        ),
      ),
    ),
  );
}
