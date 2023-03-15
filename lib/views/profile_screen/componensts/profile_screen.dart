import 'dart:io';
import 'package:chat_withmoxi/consts/consts.dart';
import 'package:chat_withmoxi/consts/controllers/profile_controller.dart';
import 'package:chat_withmoxi/views/profile_screen/componensts/picker_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../services/store_services.dart';

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
          TextButton(onPressed: ()async{
            //upload image method here
            if(controller.imgpath.isEmpty){
              //if  image is selected then only update the values
              controller.updateProfile(context);
            }else{
              //update both profile image and values
              await controller.uploadImage();
            controller.updateProfile(context);
            }
    },
              child: "Save".text.color(Colors.red).bold.size(15).make()),
        ],
      ),
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
        alignment: Alignment.center,
        padding:  const EdgeInsets.all(8),
        child:
          //init Future builder
        FutureBuilder(
          //passing current user id to the function to get the user document
          future: StoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            //if data is loaded show the widget
            if(snapshot.hasData){
              //setting snapshot into a variable for each access
              //here document[0] means it will contain only one document,
              var data = snapshot.data!.docs[0];

              //setting values to the text controllers
              controller.nameController.text=data['name'];
              controller.phoneController.text=data['phone'];
              controller.aboutController.text=data['about'];
              return  Column(
                children: [
                  Obx(() =>
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: bgColor,
                    child: Stack(
                      children: [
                        //when image length is empty
                        controller.imgpath.isEmpty && data['image_url']==''?
                        Image.asset(
                          ic_user,
                          color: Colors.white,
                          //when imagepath is not empty means file is selected..
                        ):controller.imgpath.isNotEmpty? Image.file(File(controller.imgpath.value),
                        ).box.roundedFull.clip(Clip.antiAlias).make() :
                        //network image will appear from document
                         Image.network(data['image_url'],)
                             .box.roundedFull.clip(Clip.antiAlias).make(),
                         Positioned(
                          right: 10,
                          bottom: 15,
                          //show dialog on the top of this button.
                          child: CircleAvatar(
                            backgroundColor: bgColor,
                            child:
                            const Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              color: Colors.white,
                            ).onTap(() {
                              //using velocity on tap here. using getx dialog and passing our widget
                              //passing the context and controller to the widget
                              Get.dialog(pickerDialog(
                                context,controller
                              ));
                            })
                          ),
                        ),
                      ],
                    ),
                  ),),
                  20.heightBox,
                  const Divider(
                    color: bgColor,
                    height: 1,
                  ),
                  10.heightBox,
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: TextFormField(
                      //setting controller
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
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.black,

                    ),
                    title: TextFormField(
                      //setting controller
                      controller: controller.aboutController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        label: "About".text.semiBold.black.make(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call, color: Colors.black),
                    title: TextFormField(
                      //setting controller
                      controller: controller.phoneController,
                      style: const TextStyle( fontWeight: FontWeight.bold,
                        color: Colors.red,),
                      readOnly: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: "Phone".text.semiBold.black.make(),
                      ),
                    ),
                  ),
                ],
              );
            }
            else{
              //if data is not loaded yet show the progress indicator
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              );
            }
        },


        ),
    

      ),
      ),   );
  }
}
