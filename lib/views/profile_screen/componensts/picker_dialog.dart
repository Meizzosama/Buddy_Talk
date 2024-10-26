
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../consts/consts.dart';
import '../../../consts/strings.dart';
//settings of list_icons and titles

var listTitle = [camera, gallery, cancel];
var icons = [
  Icons.camera_alt_rounded,
  Icons.photo_size_select_actual_rounded,
  Icons.cancel_rounded
];
Widget pickerDialog(context, controller) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blue,
      child: Column(
        //setting size to min
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.bold.black.size(20).make(),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              3,
              (index) => ListTile(
                onTap: () async {
                  switch (index) {
                    //on tap of camera
                    case 0:
                      Get.back();
                      //here I am providing the camera source for picking the image
                      controller.pickImage(context, ImageSource.camera);
                      break;
                    //on tap of gallery
                    case 1:
                      Get.back();
                      //here I am providing the  source as gallery for picking the image
                      controller.pickImage(context, ImageSource.gallery);
                      break;
                    //on tap of cancel
                    case 2:
                      //close the dialog
                      Get.back();
                      break;
                    default:
                  }
                },
                //getting icons from our list.
                leading: Icon(
                  icons[index],
                  color: Colors.black,
                ),
                //getting titles from our list
                title: listTitle[index].text.black.make(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
