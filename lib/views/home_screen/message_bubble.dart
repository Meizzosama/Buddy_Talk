
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../chat_screen/components/chat_screen.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mm a").format(t);
  return Card(
    color: Colors.white,
    child: ListTile(
      onTap: () {
        Get.to(() => const ChatScreen(),
            transition: Transition.zoom,
            arguments: [
              currentUser!.uid == doc['toId']
                  ? doc['friend_name']
                  : doc['user_name'],
              currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId']
            ]);
      },
      leading: CircleAvatar(
        radius: 20,
        child: Image.asset(
          ic_user,
        ),
      ),
      title: Text(
        "${doc['friend_name']}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: "${doc['last_msg']}".text.maxLines(1).size(14).make(),
      trailing: time.text.color(Colors.black).bold.make(),
    ),
  );
}
