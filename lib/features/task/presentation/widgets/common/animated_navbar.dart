// import 'dart:async';

// import 'package:crop_image/crop_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_achievments/core/constant/colors.dart';
// import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
// import 'dart:ui' as ui;

// import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
// import 'package:image_crop/image_crop.dart';

// class AnimatedNavbar<T> extends StatelessWidget {
//   const AnimatedNavbar(this.text, {
//     super.key, 
//     this.data,
//     this.onBackTapped,
//     required this.user,
//   });
//   final UserEntity user;
//   final String text;
//   final T? data;
//   final Function(dynamic data)? onBackTapped;
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: [0.0,3],
//             colors: [
//               gradientColor,
//               gradientColor2,
//             ],
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 ImageCrop.cropImage(file: file, area: area)
//                 Image.network(user.avatar.photoUrl)
//               ],
            
//             )
//           ],
//         ),);
//   }
//   Future<ui.Image> loadImage(String url) async {
//     final imageProvider = NetworkImage(url, );
//     final completer = Completer<ui.Image>();
//     final stream = imageProvider.resolve(const ImageConfiguration());
//     final listener = ImageStreamListener((ImageInfo info, _) {
//       completer.complete(info.image);
//     });
//     stream.addListener(listener);
//     return completer.future;
//   }
// }


// class MyCustomPainter extends CustomPainter {
//   final ui.Image image;
//   final double left;
//   final double top;
//   final double right;
//   final double bottom;

//   MyCustomPainter(this.image, {required this.left, required this.top, required this.right, required this.bottom});

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Define the source rectangle (entire image)
//     final src = Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble());

//     // Define the destination rectangle
//     final dst = Rect.fromLTRB(left, top, right, bottom);

//     // Draw the image
//     canvas.drawImageRect(image, src, dst, Paint());
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
