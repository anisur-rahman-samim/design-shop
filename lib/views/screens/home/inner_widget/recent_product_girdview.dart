import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/product_controller.dart';
import 'package:shop/controllers/product_details_controller.dart';
import 'package:shop/utils/app_url/app_urls.dart';

import '../../../../controllers/folder_controller.dart';
import '../../../../controllers/searchControler.dart';
import '../../details product/details_product_screen.dart';
import '../function/create_folder_dailog.dart';

class RecentProductGirdView extends StatelessWidget {
  RecentProductGirdView({super.key});

  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());

  FolderController folderController = Get.put(FolderController());

  FolderCreateDialog folderCreateDialog = FolderCreateDialog();

  ProductController productController = Get.put(ProductController());
  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => productController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          itemCount: productController.product_model!.data!.attributes!.length,
          crossAxisSpacing: 4,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = productController
                .product_model!.data!.attributes![index];
            return GestureDetector(
              onTap: () {
                productDetailsController.getProductDetailsRepo(
                    item.sId!, item.productName!,context,);
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Image.network(
                    item.productImage!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
