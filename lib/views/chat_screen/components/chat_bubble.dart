import 'package:chat_withmoxi/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
Widget chatBubble(index,DocumentSnapshot doc){
  var t=doc['created_on']==null? DateTime.now():doc['created_on'].toDate();
  var time = intl.DateFormat("h:mm a").format(t);
  return Directionality(
    textDirection: doc['uid'] == currentUser!.uid?TextDirection.rtl:TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
            doc['uid'] == currentUser!.uid? Colors.cyan : Colors.greenAccent,
            child: Image.asset(
              ic_user,
              color: Colors.black,
            ),),
          20.widthBox,
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: doc['uid'] ==currentUser!.uid
                        ? Colors.cyan
                        : Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      "${doc['msg']}"
                          .text
                          .bold
                          .size(13)
                          .make(),
                      Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: time.text.size(8).italic.bold.make(),
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ),),
        ],),
    ),
  );
}