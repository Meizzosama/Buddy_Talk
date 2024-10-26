import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/consts.dart';
import '../../../consts/controllers/profile_controller.dart';
import '../../../services/store_services.dart';
import 'picker_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init profile controller
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: profile.text.black.make(),
        backgroundColor: Colors.black12,
        elevation: 0.0,
        actions: [
          //here we can update the profile.
          TextButton(
              onPressed: () async {
                //upload image method here
                if (controller.imgpath.isEmpty) {
                  //if  image is selected then only update the values
                  controller.updateProfile(context);
                } else {
                  //update both profile image and values
                  await controller.uploadImage();
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.color(Colors.red).bold.size(15).make()),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child:
              //init Future builder
              FutureBuilder(
            future: StoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var docs = snapshot.data!.docs;
                if (docs.isNotEmpty) {
                  var data = docs[0];

                  // setting values to the text controllers
                  controller.nameController.text = data['name'];
                  controller.phoneController.text = data['phone'];
                  controller.aboutController.text = data['about'];

                  return Column(
                    children: [
                      Obx(() => CircleAvatar(
                            radius: 80,
                            backgroundColor: bgColor,
                            child: Stack(
                              children: [
                                controller.imgpath.isEmpty &&
                                        data['image_url'] == ''
                                    ? Image.asset(
                                        ic_user,
                                        color: Colors.white,
                                      )
                                    : controller.imgpath.isNotEmpty
                                        ? Image.file(
                                            File(controller.imgpath.value),
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .make()
                                        : Image.network(
                                            data['image_url'],
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .make(),
                                Positioned(
                                  right: 10,
                                  bottom: 15,
                                  child: CircleAvatar(
                                    backgroundColor: bgColor,
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ).onTap(() {
                                      Get.dialog(
                                          pickerDialog(context, controller));
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      20.heightBox,
                      const Divider(color: bgColor, height: 1),
                      10.heightBox,
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.black),
                        title: TextFormField(
                          controller: controller.nameController,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            label: "Name".text.black.make(),
                            isDense: true,
                            hintText: "Muhammad Osama Noor",
                            labelStyle: const TextStyle(
                              fontFamily: bold,
                            ),
                          ),
                        ),
                        subtitle: namesub.text.black.semiBold.size(13).make(),
                      ),
                      // Additional ListTiles for other fields
                    ],
                  );
                } else {
                  // Handle the case where there are no documents (empty result)
                  return Center(child: Text("No profile data available"));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text("An error occurred"));
              } else {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
