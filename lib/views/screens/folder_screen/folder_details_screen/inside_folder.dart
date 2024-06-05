import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../main.dart';


class ImageListInFolderScreen extends StatefulWidget {
  final String folderName;

  ImageListInFolderScreen({required this.folderName});

  @override
  _ImageListInFolderScreenState createState() => _ImageListInFolderScreenState();
}

class _ImageListInFolderScreenState extends State<ImageListInFolderScreen> {
  late Box<ImageModel> box;
  late List<ImageModel> images;

  @override
  void initState() {
    super.initState();
    box = Hive.box<ImageModel>('images');
    images = box.values.where((image) => image.folderName == widget.folderName).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images in ${widget.folderName}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await _showDeleteConfirmationDialog(context, images[index]);
            },
            child: Image.network(images[index].imagePath),
          );
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, ImageModel image) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Image'),
          content: Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                image.delete();
                setState(() {
                  images = box.values.where((image) => image.folderName == widget.folderName).toList();
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
