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
    final note = box.values.map((image) => image.note).toSet().toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.yourFolder,
          style: TextStyle(color: Color(0xFF54A630)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: folders.length,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
             /*   Get.to(() => FolderDetailsScreen(
                  folderName: folders.,
                  note: folders.folderSubTitle,
                  image: folder.folderImage,
                  productName: folder.note,
                  price: folder.price.toString(),
                ));*/
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageListInFolderScreen(folderName: folders[index]),
                  ),
                );
              },
              onLongPress: () {
                _showEditDialog(context, folders[index]);
              },
              /* child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: const Color(0xFF54A630),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: Stack(
                            children: [
                              Image.network(
                                folder.folderImage,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(Icons.error),
                                    ),
                                  );
                                },
                              ),
                            //  Text(folderCount.toString()),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    box.delete(folder.key);
                                    Get.snackbar(
                                        "Folder Delete", "Deleted Successfully");
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8),
                                    color: Colors.black.withOpacity(0.4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Folder: ${folder.folderTitle}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.white),
                                        ),
                                        Text(
                                          "Note: ${folder.folderSubTitle} (Items: $folderCount)",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),*/
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: const Color(0xFF54A630),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 0))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: 8),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "Folder: ${folders[index]}",
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Text(
                          "Note: ${note[index]}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ),
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
              TextField(
                controller: _noteController,
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
              onPressed: () {
                final newFolderName = _folderController.text;
                final newNote = _noteController.text;

                if (newFolderName.isNotEmpty) {
                  for (var image in imagesInFolder) {
                    image.folderName = newFolderName;
                    image.note = newNote;
                    image.save();
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