// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shop/models/boxes.dart';
import 'package:shop/models/folder_hive_model.dart';
import 'package:shop/utils/app_images.dart';
import 'package:shop/views/screens/folder_screen/folder_details_screen/folder_details_screen.dart';
import '../../../controllers/folder_controller.dart';
import '../../../main.dart';
import '../../../utils/app_string.dart';
import '../details product/details_product_screen.dart';
import 'folder_details_screen/inside_folder.dart';
import 'folder_list_screen/folder_list_screen.dart';

class FolderScreen extends StatelessWidget {
  FolderScreen({Key? key}) : super(key: key);

  final FolderController folderController = Get.put(FolderController());

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ImageModel>('images');
    final folders = box.values.map((image) => image.folderName).toSet().toList();
    final imagePath = box.values.map((image) => image.imagePath).toSet().toList();
    final note = box.values.map((image) => image.note).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          AppString.yourFolder,
          style: TextStyle(color: Color(0xFF54A630)),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: folders.length,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageListInFolderScreen(folderName: folders[index]),
                  ),
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: const Color(0xFF54A630),),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Stack(
                  children: [
                    Image.network(imagePath[index]),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: Get.width / 2.08,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:  Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                         child: Column(
                           children: [
                             Center(child: Text(
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               folders[index],
                               style: const TextStyle(
                                   fontSize: 14,
                                   color: Colors.white),
                             ),),
                             Text(
                               "Note: ${note[index]}",
                               overflow: TextOverflow.ellipsis,
                               maxLines: 1,
                               style: const TextStyle(
                                   fontSize: 12,
                                   color: Colors.white),
                             ),
                           ],
                         ),
                         /* child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                folders[index],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                           *//*   Text(
                                "Note: ${note[index]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white),
                              ),*//*
                            ],
                          ),*/
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            _showEditDialog(context, folders[index]);
                          },
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.edit,size: 14,)),
                        )
                    )
                  ],
                ),
              )
            );
          },
        ),
      )
    );
  }
  void _showEditDialog(BuildContext context, String currentFolderName) {
    final _folderController = TextEditingController(text: currentFolderName);
    final _noteController = TextEditingController();

    final box = Hive.box<ImageModel>('images');
    final imagesInFolder = box.values.where((image) => image.folderName == currentFolderName).toList();

    if (imagesInFolder.isNotEmpty) {
      _noteController.text = imagesInFolder.first.note;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Folder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _folderController,
                decoration: InputDecoration(labelText: 'Folder Name'),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: ()async {
                final newFolderName = _folderController.text;
                final newNote = _noteController.text;

                if (newFolderName.isNotEmpty && newNote.isNotEmpty) {
                  for (var image in imagesInFolder) {
                    image.note = newNote;
                    image.folderName = newFolderName;

                   await image.save();
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }


}