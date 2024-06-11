import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/views/screens/folder_screen/folder_screen.dart';
import '../../../../controllers/product_details_controller.dart';
import '../../../../main.dart';

class ImageListInFolderScreen extends StatefulWidget {
  final String folderName;

  ImageListInFolderScreen({required this.folderName});

  @override
  _ImageListInFolderScreenState createState() =>
      _ImageListInFolderScreenState();
}

class _ImageListInFolderScreenState extends State<ImageListInFolderScreen> {
  late Box<ImageModel> box;
  late List<ImageModel> images;
  ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  @override
  void initState() {
    super.initState();
    box = Hive.box<ImageModel>('images');
    images = box.values
        .where((image) => image.folderName == widget.folderName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.folderName),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          itemCount: images.length,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return Container(
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
                  InkWell(
                      onTap: (){
                        productDetailsController.getProductDetailsRepo(
                          images[index].imageId, images[index].imageName,context,);
                      },
                      child: Image.network(images[index].imagePath)),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                          onPressed: ()async {
                            await _showDeleteConfirmationDialog(context, images[index],);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, ImageModel image,) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                image.delete();
                setState(() {
                  images = box.values
                      .where((image) => image.folderName == widget.folderName)
                      .toList();
                  //   box = Hive.box<ImageModel>('images');

                });
                Navigator.of(context).pop();

              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
