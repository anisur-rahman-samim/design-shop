import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/home_controller.dart';
import 'package:shop/utils/app_colors.dart';
import 'package:shop/utils/app_url/app_urls.dart';

class HomeScreenSilder extends StatelessWidget {
  HomeScreenSilder({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CarouselSlider.builder(
            itemCount: homeController.silderModel!.data!.attributes!.length,
            options: CarouselOptions(
              autoPlay: true,
              height: 180.h,
              aspectRatio: 5.5,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              reverse: false,
            ),
            itemBuilder: (context, index, realIndex) {
              var item = homeController.silderModel!.data!.attributes?[index];
              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Container(
                    height: 200.h,
                    width: 400.w,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
                    decoration: ShapeDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("${AppUrls.imageUrl}${item!.sliderImage}")),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ]
                    ),
                    // child: ClipRRect(
                    //   // borderRadius: BorderRadius.circular(13.r),
                    //   child: Image.network(item!.sliderImage.toString(),
                    //       fit: BoxFit.fill),
                    // ),
                  ),
                ),
              );
            },
          ));
  }
}
