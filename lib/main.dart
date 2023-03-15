

import 'package:chat_withmoxi/consts/colors.dart';
import 'package:chat_withmoxi/consts/images.dart';
import 'package:chat_withmoxi/consts/strings.dart';
import 'package:chat_withmoxi/consts/utils.dart';
import 'package:chat_withmoxi/views/chat_screen/components/chat.dart';
import 'package:chat_withmoxi/views/home_screen/home_screen.dart';
import 'package:chat_withmoxi/views/intro_screen/verification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'consts/firebase_consts.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white38,
        statusBarIconBrightness: Brightness.dark),
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var isUser = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        setState(() {
          isUser = false;
        });
      } else {
        setState(() {
          isUser = true;
        });
      }
      print("User Value is @isUser");
    });
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: "lato"),
      debugShowCheckedModeBanner: false,
      home: isUser ? HomeScreen() : const ChatApp(),
      title: appname,
    );
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logo,
                      color: Colors.black54,
                      width: 150,
                      height: 130,
                    ),
                    appname.text.size(25).fontFamily(bold).make(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 8,
                    children: List.generate(listOfFeatures.length, (index) {
                      return Chip(
                          backgroundColor: Colors.transparent,
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          side: const BorderSide(
                            color: Colors.black87,
                          ),
                          label: listOfFeatures[index].text.semiBold.make());
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  slogan.text.size(35).fontFamily(bold).letterSpacing(2).make(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    width: context.screenWidth - 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // <-- Radius
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Get.to(() => const VerificationScreen(),
                            transition: Transition.downToUp);
                      },
                      child: cont.text.size(16).make(),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  poweredby.text.size(15).fontFamily(bold).make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
