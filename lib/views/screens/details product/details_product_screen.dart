import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shop/controllers/hive_controller.dart';
import 'package:shop/controllers/product_details_controller.dart';
import 'package:shop/models/hive_model.dart';
import '../../../controllers/product_controller.dart';
import '../../../controllers/searchControler.dart';
import '../../../main.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_string.dart';
import '../../widgets/costom_multiline_text.dart';
import '../../widgets/custom_text.dart';
import '../home/function/create_folder_dailog.dart';

class DetailsProductScreen extends StatefulWidget {
 final String id;
 final String name;
  DetailsProductScreen({super.key, this.name = "",this.id = ""});



  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  RxBool isInfo = false.obs;

  ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  FolderCreateDialog folderCreateDialog = FolderCreateDialog();

  HiveController hiveController = Get.put(HiveController());
  ProductController productController = Get.put(ProductController());
  SearchScreenController searchScreenController =
  Get.put(SearchScreenController());

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (productController.product_model!.data!.attributes!.length == _counter) {
        _counter = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    hiveController.cartList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(color: Color(0xFF54A630)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                  child: Stack(
                    children: [
                      PhotoView(
                        imageProvider: NetworkImage(productDetailsController
                            .productDetails_Model!.data!.attributes!.productImage!),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2.0,
                        enableRotation: true,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                   setState(() {
                                     _decrementCounter();
                                     productDetailsController.getProductDetailsRepo(
                                         productController.product_model!.data!.attributes![_counter].sId.toString(),  productController.product_model!.data!.attributes![_counter].productName);
                                   });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: Center(child: Icon(Icons.arrow_back_ios,color: Colors.black,),),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                   setState(() {
                                     _incrementCounter();
                                     productDetailsController.getProductDetailsRepo(
                                         productController.product_model!.data!.attributes![_counter].sId.toString(),  productController.product_model!.data!.attributes![_counter].productName);

                                   });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,),),
                                  ),
                                ),
                              ],
                            ),
                          )
                      )
                    ],
                  )),
            ),
            SizedBox(height: 16.h),
            Obx(
                  () =>
              isInfo.value
                  ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      /*  CustomText(
                                title:
                                    "Design Name : ${productDetailsController.productDetails_Model!.data!.attributes!.productName!}",
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF54A630)),
                            const SizedBox(
                              height: 4,
                            ),*/
                      Row(
                        children: [
                          CustomText(
                              title:
                              "Price : ${productDetailsController
                                  .productDetails_Model!.data!.attributes!
                                  .productPrice!} ",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF54A630)),
                          SvgPicture.asset(AppIcon.bdTK,
                              height: 14.h, color: const Color(0xFF54A630)),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: AppString.description,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF54A630),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomMultiLineText(
                        title: productDetailsController
                            .productDetails_Model!
                            .data!
                            .attributes!
                            .productDescription![0],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              )
                  : SizedBox(),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: IconButton(
                  onPressed: () {
                    /*  folderCreateDialog.createFolder(
                     context,
                     productDetailsController
                         .productDetails_Model!.data!.attributes!.productName!,
                     productDetailsController.productDetails_Model!.data!
                         .attributes!.productImage!,
                     productDetailsController
                         .productDetails_Model!.data!.attributes!.productPrice!
                         .toString(),
                     productDetailsController.productDetails_Model!.data!
                         .attributes!.productDescription![0]);*/
                    _showDialog(context,
                        productDetailsController.productDetails_Model!.data!
                            .attributes!.productImage!,productDetailsController.productDetails_Model!.data!
                            .attributes!.sId!, productDetailsController.productDetails_Model!.data!
                            .attributes!.productName!);
                  },
                  icon: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.black12,
                      child: const Icon(
                        Icons.create_new_folder_outlined,
                        color: Color(0xFF54A630),
                      ))),),
            BottomNavigationBarItem(label: "", icon: IconButton(
                onPressed: () {
                  productDetailsController.downloadImage(
                      productDetailsController.productDetails_Model!.data!
                          .attributes!.productImage!);
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.download_rounded,
                      color: Color(0xFF54A630),
                    ))),),
            BottomNavigationBarItem(label: "", icon: IconButton(
                onPressed: () {
                  NotesModel notesModel = NotesModel(
                      title: widget.name,
                      description: productDetailsController
                          .productDetails_Model!
                          .data!
                          .attributes!
                          .productDescription![0],
                      image: productDetailsController.productDetails_Model!
                          .data!.attributes!.productImage!,
                      price: productDetailsController
                          .productDetails_Model!.data!.attributes!.productPrice
                          .toString());

                  hiveController.addToCart(notesModel);
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: Obx(() =>
                        Icon(
                          hiveController.isCartAdded.contains(widget.name)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFF54A630),
                        )))),),
            BottomNavigationBarItem(label: "", icon: IconButton(
                onPressed: () {
                  if (isInfo.value == true) {
                    isInfo.value = false;
                  } else {
                    isInfo.value = true;
                  }
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF54A630),
                    ))))

          ]
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  folderCreateDialog.createFolder(
                      context,
                      productDetailsController
                          .productDetails_Model!.data!.attributes!.productName!,
                      productDetailsController.productDetails_Model!.data!
                          .attributes!.productImage!,
                      productDetailsController
                          .productDetails_Model!.data!.attributes!.productPrice!
                          .toString(),
                      productDetailsController.productDetails_Model!.data!
                          .attributes!.productDescription![0]);
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.create_new_folder_outlined,
                      color: Color(0xFF54A630),
                    ))),
            IconButton(
                onPressed: () {
                  productDetailsController.downloadImage(
                      productDetailsController.productDetails_Model!.data!
                          .attributes!.productImage!);
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.download_rounded,
                      color: Color(0xFF54A630),
                    ))),
            IconButton(
                onPressed: () {
                  NotesModel notesModel = NotesModel(
                      title: widget.name,
                      description: productDetailsController
                          .productDetails_Model!
                          .data!
                          .attributes!
                          .productDescription![0],
                      image: productDetailsController.productDetails_Model!
                          .data!.attributes!.productImage!,
                      price: productDetailsController
                          .productDetails_Model!.data!.attributes!.productPrice
                          .toString());

                  hiveController.addToCart(notesModel);
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: Obx(() => Icon(
                          hiveController.isCartAdded.contains(widget.name)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFF54A630),
                        )))),
            IconButton(
                onPressed: () {
                  if (isInfo.value == true) {
                    isInfo.value = false;
                  } else {
                    isInfo.value = true;
                  }
                },
                icon: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.info_outline,
                      color: Color(0xFF54A630),
                    ))),
          ],
        ),
      ),*/

    );
  }

  void _showDialog(BuildContext context, String imagePath, String imageId, String imageName) {
    var folderController = TextEditingController();
    final _noteController = TextEditingController();

    final box = Hive.box<ImageModel>('images');
    final folders = box.values.map((image) => image.folderName)
        .toSet()
        .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return folders.where((folder) =>
                      folder.toLowerCase().contains(
                          textEditingValue.text.toLowerCase()));
                },
                onSelected: (String selection) {
                  folderController.text = selection;
                },
                fieldViewBuilder: (context, controller, focusNode,
                    onEditingComplete) {
                  folderController = controller;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      labelText: 'Folder Name',
                    ),
                  );
                },
              ),
              SizedBox(height: 10,),
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
                final folderName = folderController.text;
                final note = _noteController.text;

                if (folderName.isNotEmpty && note.isNotEmpty) {
                  final bool imageExists = box.values.any((image) =>
                  image.folderName == folderName &&
                      image.imagePath == imagePath);

                  if (imageExists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'This image already exists in the selected folder.'),
                      ),
                    );
                  } else {
                    final newImage = ImageModel(imagePath, folderName, note,imageId, imageName);
                    box.add(newImage);
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

}