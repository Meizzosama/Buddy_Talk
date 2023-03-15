import 'package:chat_withmoxi/consts/consts.dart';
import 'package:chat_withmoxi/services/store_services.dart';
import 'package:chat_withmoxi/views/chat_screen/components/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "New Messages".text.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height:   double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          //2 corners should be rounded
          borderRadius: BorderRadius.vertical(top: Radius.circular(16),),
        color: Colors.white),
        //using stream-builder for realtime changes
        child: StreamBuilder(
          //stream function here
          stream: StoreServices.getAllUsers(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              //if data is not loaded yet
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
                ),
              );
            }else{ return
              //using gridview
             SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child:
             Column(
               children:[
              GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //here i am converting my snapshot to map for easy access to all of my docs
                children:
                snapshot.data!.docs.mapIndexed((currentValue, index) {
//setting our each doc into a variable for easy access
                  var doc =snapshot.data!.docs[index];
                  return
                    //wrapping card to get the elevation....
                    Card(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black.withOpacity(0.2)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage("${doc['image_url']}"),
                                ),
                                "${doc['name']}".text.bold.make(),
                              ],
                            ),
                              10.heightBox,
                              SizedBox(
                                width: double.infinity,
                                child:
                                ElevatedButton.icon(
                                  onPressed:(){
                                    //while using the message button the user will move forward to the new chat option
                                    Get.to(()=> ChatScreen(),transition: Transition.zoom,arguments: [
                                      doc['name'],
                                      doc['id'],
                                    ]);
                                  }, icon: Icon(Icons.message_rounded),
                                  label: "Message".text.make(),

                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(12),
                                      primary: bgColor),
                                ),),
                            ]),),);
                }).toList(),
             ),], ));
            }
          },
        ),
      ),
    );
  }
}
