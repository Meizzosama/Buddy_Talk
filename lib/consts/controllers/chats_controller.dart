
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../consts.dart';
import '../firebase_consts.dart';
import 'home_controller.dart';

class ChatsController extends GetxController{
  //variables of chat
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChats);
  var userId=currentUser!.uid;
  //using argument
  var friendId = Get.arguments[1];
  //it will get the name from the preferences of 0 index
  var username = HomeController.instance.prefs.getStringList('user_details')![0];
  //get through argument
  var friendname = Get.arguments[0];

  //for text controller
  var messageController=TextEditingController();
  var isloading=false.obs;

  //creating chatrooms
getChatId()async{
  isloading(true);
  //it will see if there is a chat btw 2 users
await chats.where('users',isEqualTo: {friendId:null,userId:null}).limit(1).get().then((QuerySnapshot snapshot)async{
if(snapshot.docs.isNotEmpty){
  chatId  =snapshot.docs.single.id;
}
else{
  chats.add({
    'users':{userId:null,friendId:null},
    'friend_name':friendname,
    'user_name':username,
    'toId': '',
    'fromId': '',
    "created_on": null,
    'last_msg': '',
  }).then((value){
    {
      chatId=value.id;
    }
  });
}
});
isloading(false);
}

sendmessage(String msg){
if(msg.trim().isNotEmptyAndNotNull){
//if msg is not empty or null
chats.doc(chatId).update({
  'created_on':FieldValue.serverTimestamp(),
  'last_msg':msg,
  'toId':friendId,
  'fromId':userId
});
chats.doc(chatId).collection(collectionMessages).doc().set({
  'created_on':FieldValue.serverTimestamp(),
    'msg':msg,
  'uid':userId
}).then((value){
  messageController.clear();
});
}
}


@override
  void onInit(){
  getChatId();
  super.onInit()
;}
}