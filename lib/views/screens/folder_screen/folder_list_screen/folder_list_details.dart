// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
//
// class FolderDetailsScreen extends StatelessWidget {
//
//   FolderDetailsScreen({required this.folder});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("dfd"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Use PhotoView for the image display
//             Expanded(
//               child: Center(
//                   child: PhotoView(
//                     imageProvider: NetworkImage(folder.image), // Replace with your image path
//                     minScale: PhotoViewComputedScale.contained * 0.8,
//                     maxScale: PhotoViewComputedScale.covered * 2.0,
//                     // enableRotation: true, // Enable rotation
//
//                     backgroundDecoration: const BoxDecoration(
//                       color: Colors.white,
//                     ),
//
//                   )
//
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Folder : ${folder.title}",
//               style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800, color: const Color(0xFF54A630)),),
//             SizedBox(height: 10),
//             Text(
//             "Note: ${folder.description}",
//               style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w800, color: const Color(0xFF54A630)),),
//             SizedBox(height: 20),
//             // Add more details widgets as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
