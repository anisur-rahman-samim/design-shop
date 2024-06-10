import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:shop/controllers/product_details_controller.dart';
import 'package:shop/models/boxes.dart';
import 'package:shop/models/hive_model.dart';
import 'package:shop/views/screens/wishlist/inner_widget/wishlist_item.dart';
import '../../../controllers/hive_controller.dart';
import '../../../controllers/wishlist_controller.dart';
import '../../widgets/wishlist_item.dart';
import '../details product/details_product_screen.dart';

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  WishlistController wishlistController = Get.put(WishlistController());
  HiveController hiveController = Get.put(HiveController());

  ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist",
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, child) {
                var data = box.values.toList().cast<NotesModel>();
                print(data.length.toString() + "wishlist length");

                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      "No wishlist found.",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  );
                }
               /* return MasonryListViewGrid(
                    column: 2,
                    padding: const EdgeInsets.all(8.0),
                    children: List.generate(
                      data.length,
                      (index) {
                        NotesModel item = data[index];

                      },
                    ));*/
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: data.length,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      NotesModel item = data[index];
                      return GestureDetector(
                        onTap: () {
                          // productDetailsController.getProductDetailsRepo(
                          //     item.id!,item.title!);
                        },
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Stack(
                              children: [
                                Image.network(
                                  item.image,
                                  fit: BoxFit.fitHeight,
                                ),
                                Positioned(
                                    right: -8,
                                    bottom: -8,
                                    child: IconButton(
                                        onPressed: () {
                                          print("before=========================${hiveController.isCartAdded}");
                                          item.delete();
                                          hiveController.cartList();
                                          hiveController.saveCart();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
