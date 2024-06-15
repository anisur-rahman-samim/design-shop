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
  final String note;

  ImageListInFolderScreen({required this.folderName, required this.note,});

  @override
  _ImageListInFolderScreenState createState() =>
      _ImageListInFolderScreenState();
}

class _ImageListInFolderScreenState extends State<ImageListInFolderScreen> {
  late Box<ImageModel> box;
  late List<ImageModel> images;
  late List<ImageModel> notes;
  late List<String> note;
  ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  @override
  void initState() {
    super.initState();
    box = Hive.box<ImageModel>('images');
    _loadImagesAndNotes();
  }

  void _loadImagesAndNotes() {
    images = box.values
        .where((image) => image.folderName == widget.folderName)
        .toList();
    notes = box.values
        .where((image) => image.note == widget.folderName)
        .toList();
    note = box.values.map((image) => image.note).toSet().toList();
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
        padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                      onTap: () {
                        productDetailsController.getProductDetailsRepo(
                          images[index].imageId, images[index].imageName, context,);
                      },
                      child: Image.network(images[index].imagePath)),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                          onPressed: () async {
                            await _showDeleteConfirmationDialog(context, images[index],);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))),
                  Positioned(
                      right: 0,
                      top: 40,
                      child: IconButton(
                          onPressed: () async {
                            await _showEditDialog(context, note[index], index);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ))),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: Get.width / 2.08,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            "${note[index]}",
                      /*      overflow: TextOverflow.ellipsis,
                            maxLines: 1,*/
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                  _loadImagesAndNotes();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  _showEditDialog(BuildContext context, String currentNote, int index) {
    final _noteController = TextEditingController(text: currentNote);
    final imagesInFolder = box.values.where((image) => image.note == currentNote).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newNote = _noteController.text;

                if (newNote.isNotEmpty) {
                  for (var image in imagesInFolder) {
                    image.note = newNote;
                    await image.save(); // Save the image after updating the note
                  }

                  // After updating and saving the images, refresh the UI
                  setState(() {
                    _loadImagesAndNotes();
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
