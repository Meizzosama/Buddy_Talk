import 'package:chat_withmoxi/consts/consts.dart';

Widget statusComponent(){
  return Container(
padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            child: Image.asset(ic_user,color: Colors.white,),
          ),
          title: "My Status".text.fontFamily(bold).color(Colors.black).make(),
          subtitle: "Tap to add Status Updates".text.color(Colors.black).make(),
        ),
        20.heightBox,
        recentupdates.text.color(Colors.teal).size(15).bold.make(),
        ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (BuildContext context,int index){
  return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child:ListTile(
  leading:
  Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.greenAccent,width: 3)
    ),
    child:
  CircleAvatar(
    radius: 25,
  backgroundColor: Vx.randomOpaqueColor,
  child: Image.asset(ic_user),
  ),),
title: "Username".text.bold.black.size(17).make(),
        subtitle: "Today 12:34 Am".text.black.make(),
      ),);
  }),
      ],
    ),
  );
}