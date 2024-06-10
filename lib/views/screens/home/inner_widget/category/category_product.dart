
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/category_controller.dart';
import 'package:shop/controllers/product_details_controller.dart';
import 'package:shop/utils/app_string.dart';
import 'package:shop/utils/app_url/app_urls.dart';

class CategoryProductScreen extends StatelessWidget {
  CategoryProductScreen({super.key, required this.name});

  String name ;

  CategoryController categoryController = Get.put(CategoryController()) ;
 ProductDetailsController productDetailsController = Get.put(ProductDetailsController()) ;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: TextStyle(color: Color(0xFF54A630)),),
        centerTitle: true,
      ),
     body: Obx(() => categoryController.isLoading.value
         ? const Center(
       child: CircularProgressIndicator(),
     )
         : Padding(
           padding:  EdgeInsets.symmetric(horizontal: 8.w),
           child: MasonryGridView.count(
             crossAxisCount: 2,
             mainAxisSpacing: 4,
             itemCount: categoryController.product_model!.data!.attributes!.length,
             crossAxisSpacing: 4,
             itemBuilder: (context, index) {

               return GestureDetector(
                 onTap: () {
                   productDetailsController.getProductDetailsRepo(
                       categoryController!
                           .product_model!.data!.attributes![index].sId!,categoryController!
                       .product_model!.data!.attributes![index].productName!,context,);
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
                       categoryController.product_model!.data!
                           .attributes![index].productImage!,
                       fit: BoxFit.fitHeight,
                     ),
                   ),
                 ),
               );
             },
           ),
         )),
    );
  }
}
