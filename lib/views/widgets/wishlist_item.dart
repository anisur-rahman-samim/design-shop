import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/app_url/app_urls.dart';

import 'custom_text.dart';


class ProductListItem extends StatelessWidget {
  ProductListItem({
    super.key,
    required this.name,
    required this.image,
    this.variant = " ",
    required this.price,
  });

  String image;

  String name;

  String variant;

  String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(flex: 2, child: Image.network("${AppUrls.imageUrl}$image")),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
              flex: 7,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                          color: const Color(0xFF393F42),
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                
                  CustomText(title: "\$ $price")
                ],
              )),
          
        ],
      ),
    );
  }
}
