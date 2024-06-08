import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/views/screens/search_screen/search_screen.dart';

class CustomMultiLineText extends StatelessWidget {
  CustomMultiLineText(
      {super.key,
      required this.title,
      this.textAlign = TextAlign.start,
      this.color});

  String title;

  TextAlign textAlign;

  Color? color = const Color(0xFF393F42);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => SearchScreen(search: title,));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6),
          child: Text(
            title,
            textAlign: textAlign,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontFamily: 'InterInter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
