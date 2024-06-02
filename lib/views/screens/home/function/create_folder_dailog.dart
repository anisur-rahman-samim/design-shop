import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop/controllers/folder_controller.dart';
import 'package:shop/controllers/hive_controller.dart';
import 'package:shop/models/boxes.dart';
import 'package:shop/models/folder_hive_model.dart';
import 'package:shop/utils/app_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FolderCreateDialog {
  createFolder(
    BuildContext context,
    String name,
    String image,
    String price,
    String note,
  ) {
    FolderController folderController = Get.put(FolderController());
    TextEditingController folderNameController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    HiveController hiveController = Get.put(HiveController());

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppString.createFolder),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: folderNameController,
                  decoration: InputDecoration(
                      labelText: AppString.folderName,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r)))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextField(
                  maxLines: null,
                  controller: noteController,
                  decoration: InputDecoration(
                      labelText: AppString.note,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r)))),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(AppString.cancel),
            ),
            TextButton(
              onPressed: () {
                Box<FolderModel> folderBox = Boxes.getFolderData();

                String folderImage = image;
             //   String folderImage = folderBox.v;


                // Check if a folder with the same image already exists
                FolderModel? existingFolder = folderBox.values.firstWhereOrNull(
                    (folder) => folder.folderImage == folderImage);

                var folderName = folderBox.values.map((e) => e.folderTitle).contains(folderNameController.text);

             print("${folderName} --------------------------");



                if (existingFolder != null) {
                  // Update the existing folder
                  existingFolder.folderTitle = folderNameController.text;
                  existingFolder.folderSubTitle = noteController.text;
                  existingFolder.price = double.parse(price);
                  existingFolder.note = note;
                  existingFolder.folderImage = image;

                  existingFolder.save();
                  print("update ==================");
                  Get.snackbar("Folder", "Folder updated successfully");

                } else if(folderName == true){
                  Get.snackbar("Folder", "Folder name already exist ");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Folder name already exist")));
                  print("already ==================");
                }
                else {
                  // Create a new folder
                  FolderModel newFolder = FolderModel(
                    folderTitle: folderNameController.text,
                    folderSubTitle: noteController.text,
                    folderImage: folderImage,
                    price: double.parse(price),
                    note: note,
                  );

                  folderBox.add(newFolder);
                  print("new ==================");

                  Get.snackbar("Folder", "Folder created successfully");

                }

                Get.back();
                Navigator.pop(context);
                print("xxxx ==================");
              },
              child: const Text(AppString.create),
            ),
          ],
        );
      },
    );
  }
}
