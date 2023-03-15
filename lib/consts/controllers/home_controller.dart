import 'package:chat_withmoxi/consts/firebase_consts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

  class HomeController extends GetxController{
  late SharedPreferences prefs;

//creating a variable to access  home controller variables in other controllers
  static HomeController instance = Get.find();

  String username = '';
  String userImage = '';

getUsersDetails()async{

  await firebaseFirestore.collection(collectionUser).where('id',isEqualTo: currentUser!.uid).get().then((value)
  async {
    username = value.docs[0]['name'];
    userImage =value.docs[0]['image_url'];
    //here i am getting th current user details, stored in the value variable
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList('user_details',[
      //store name and image url on index 0 & 1
      value.docs[0]['name'],
    value.docs[0]['image_url']
    ]);
  });
}

//execute this method
@override
  void onInit(){
  getUsersDetails();
  super.onInit();
}

}