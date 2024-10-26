import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'consts/colors.dart';
import 'consts/firebase_consts.dart';
import 'consts/images.dart';
import 'consts/strings.dart';
import 'consts/utils.dart';
import 'views/home_screen/home_screen.dart';
import 'views/intro_screen/verification_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white38,
      statusBarIconBrightness: Brightness.dark,
    ),
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

  void checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (!mounted) return;
      setState(() {
        isUser = user != null;
      });
      print("User Value is $isUser");
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
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8, // Adjust spacing for better layout
                      runSpacing: 8, // Vertical spacing between elements
                      children: List.generate(listOfFeatures.length, (index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            listOfFeatures[index],
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 45), // Space below feature list
                    slogan.text
                        .size(30)
                        .fontFamily(bold)
                        .letterSpacing(1.5)
                        .make(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    width: context.screenWidth - 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Get.to(
                          () => const VerificationScreen(),
                          transition: Transition.downToUp,
                        );
                      },
                      child: cont.text.size(16).make(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  poweredby.text.size(15).center.fontFamily(bold).make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//otp pass =123456
