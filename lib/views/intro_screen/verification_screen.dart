import 'package:chat_withmoxi/consts/controllers/auth_controller.dart';
import 'package:chat_withmoxi/views/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_withmoxi/consts/strings.dart';
import '../../consts/colors.dart';
import '../../consts/utils.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: letsconnect.text
            .color(Colors.black)
            .fontFamily(bold)
            .align(TextAlign.center)
            .make(),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            //username..

            Form(
                key: controller.formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Please enter your Username";
                        }
                      },
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Vx.gray400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Vx.gray400)),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Vx.gray600,
                        ),
                        alignLabelWithHint: true,
                        labelText: "Username",
                        hintText: "eg. meizzosama",
                        labelStyle: const TextStyle(
                            color: Vx.gray600, fontWeight: FontWeight.bold),
                      ),
                    ),
                    20.heightBox,
                    //phone number
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Please Enter your Phone number";
                        }
                      },
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Vx.gray400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Vx.gray400)),
                        prefixIcon: const Icon(
                          Icons.phone_iphone_rounded,
                          color: Vx.gray600,
                        ),
                        alignLabelWithHint: true,
                        labelText: "Phone Number",
                        prefixText: "+92 ",
                        hintText: "eg. 0123456789",
                        labelStyle: const TextStyle(
                            color: Vx.gray600, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            20.heightBox,
            otp.text.semiBold.size(15).align(TextAlign.start).make(),
            20.heightBox,
            //otp field

            Obx(
              () => Visibility(
                visible: controller.isOtpSent.value,
                child: SizedBox(
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 46,
                                child: TextField(
                                  controller: controller.otpController[index],
                                  cursorColor: Colors.black,
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontFamily: bold, color: Colors.black),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      hintText: "*"),
                                ),
                              ))),
                ),
              ),
            ),
            const Spacer(),
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
                onPressed: () async {
                  if (controller.formkey.currentState!.validate()) {
                    if (controller.isOtpSent.value == false) {
                      controller.isOtpSent.value = true;
                      await controller.sendOtp();
                    } else {
                      await controller.verifyOtp(context);
                    }
                  }
                },
                child: contText.text.size(16).make(),
              ),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
