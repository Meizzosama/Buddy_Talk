import '../../consts/consts.dart';
import '../../consts/controllers/home_controller.dart';

Widget statusComponent(){
  return Container(
padding: const EdgeInsets.symmetric(horizontal: 12),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(HomeController.instance.userImage,)
            ),
            title: "My Status".text.fontFamily(bold).color(Colors.black).make(),
            subtitle: "Tap to add Status Updates".text.color(Colors.black).make(),
          ),
          20.heightBox,
          recentupdates.text.color(Colors.black).size(15).bold.make(),
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
        border: Border.all(color: Colors.transparent,width: 3,)
      ),
      child:
      CircleAvatar(
        backgroundColor: bgColor,
        radius: 30,
        backgroundImage: NetworkImage(HomeController.instance.userImage,),
      ).box.roundedFull.clip(Clip.antiAlias).make(),
      
      
       ),
      title: "Name".text.bold.black.size(17).make(),
          subtitle: "Today 12:34 Am".text.black.make(),
        ),);
        }),
        ],
      ),
    ),
  );
}