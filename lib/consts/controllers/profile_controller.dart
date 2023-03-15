import 'dart:io';
import 'package:chat_withmoxi/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
//text editing controllers

  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  //variables of image
  var imgpath=''.obs;
  var imglink='';

  //update profile method:
  updateProfile(context) async {
    //setting the store variables to the doc of our current user..
    var store =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    //for updating the data
   await store.set({
      'name':nameController.text,
      'about':aboutController.text,
      //not to update the phone number because it cant be changed..
     //update the img_url field
     //it will be empty if image is not selected
     'image_url':imglink
    }, SetOptions(
      merge:true,
    ));
    //the toast will appear when the profile completes successfully.
    VxToast.show(context, msg: "Profile Updated Successfully");
    }
//image picking method
  pickImage(context,source) async {

    final img=await ImagePicker().pickImage(source: source,imageQuality: 80);
    VxToast.show(context, msg: "Image Selected");
//setting our variables according to our image path
    imgpath.value=img!.path;
  }
  //uploading image to the firesotre
  uploadImage()async{
    //getting the file selected
    //importing path.dart for the basename
    //adding path of selected image

    var name=basename(imgpath.value);
    //setting destination of the file on to firestore
    //here it will create a path in storage
   //and in that folder it will create a folder with current user id
    //and in  that folder it will store our file

    var destination='images/${currentUser!.uid}/$name';
 //triggering fire storage to save out file
    //adding the destination to create a file
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    //uploading our file
 await ref.putFile(File(imgpath.value));
  //getting url of our uploaded file and saving it into our imglink variable
    var d=await ref.getDownloadURL();
    print(d);
    imglink =d;

  }


}