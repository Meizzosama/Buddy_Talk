import 'package:chat_withmoxi/consts/consts.dart';
import 'package:chat_withmoxi/consts/controllers/chats_controller.dart';
import 'package:chat_withmoxi/consts/controllers/home_controller.dart';
import 'package:chat_withmoxi/services/store_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    //init out chats controller
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text:   TextSpan(children: [
                      TextSpan(
                        //using the username from chat-screen
                        text: "${controller.friendname}\n",
                        style: const TextStyle(
                            fontFamily: bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      const TextSpan(
                        text: "Last Seen",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),]),),),
                 CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: IconButton(onPressed:(){}, icon: Icon(Icons.video_camera_back_rounded),),
                ),
                10.widthBox,
                 CircleAvatar(
                  backgroundColor: Colors.cyan,
                   child: IconButton(onPressed:(){}, icon: Icon(Icons.phone),),
                 ),],),
            30.heightBox,
            //this is the chat body
            Obx(() =>
            Expanded(
              //here im going to use stream builder for realtime chat
              child: controller.isloading.value ? const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(bgColor),
              ),):
              StreamBuilder(
                stream: StoreServices.getChats(controller.chatId),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData){
                    return Container(

                    );
                  }else{
                    return ListView(
                      children: snapshot.data!.docs.mapIndexed((currentValue, index){
                        var doc=snapshot.data!.docs[index];
                        return chatBubble(index,doc);
                      }).toList(),
                    );
                  }
                },
              ),
            ),),
            10.heightBox,
            SizedBox(
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: controller.messageController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.emoji_emotions_rounded,
                            color: Colors.black87,
                          ),
                          suffixIcon: Icon(
                            Icons.attachment_rounded,
                            color: Colors.black,
                          ),
                          icon: Icon(
                            Icons.mic_rounded,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          hintText: "Type msg here....",
                          hintStyle: TextStyle(
                            fontFamily: bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),),),),),
                  20.widthBox,
                  GestureDetector(
                    onTap: (){
                      //on tap of this will send a msg
                      controller.sendmessage(controller.messageController.text);
                    },
                  child:
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),),),],),),],),),);}}