import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/routes/router.dart';
import 'package:flutter_achievments/features/app/presentation/provider/selected_user_provider.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_bloc_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_messages_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/task_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SelectedUserProvider()),
        Provider(create: (_) => ChatBlocProvider()),
        ChangeNotifierProvider(create: (_) => ChatMessagesProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider())
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
            dialogBackgroundColor: Colors.white,
            indicatorColor: lightBlue,
            fontFamily: 'Montserrat',
            textTheme: const TextTheme(
                titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
            )),
            colorScheme: ColorScheme.fromSeed(seedColor: borderBlueColor),
            useMaterial3: true,
            scaffoldBackgroundColor: scaffoldBackground,
          ),
          onGenerateRoute: onGenerateRoutes,
          // onGenerateRoute: onGenerateRoutes,
          // home: ImageCropPage(
          //   image: Image.network(
          //       'https://firebasestorage.googleapis.com/v0/b/flutter-achieve.appspot.com/o/avatars%2FQKszsTsKZdhmrCszeKya042TGQ62?alt=media&token=f12e853d-c6b3-44e5-8bd7-4869460061c0'),
          // )
        ),
      ),
    );
  }
}

// //

// class ImageCropPage extends StatelessWidget {
//   final Image image;

//   const ImageCropPage({Key? key, required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const CustomNavBar('Настройка аватара', data: null),
//         body: SafeArea(
//           child: ImageCropBody(
//             image: image,
//           ),
//         ));
//   }
// }

// class ImageCropBody extends StatefulWidget {
//   const ImageCropBody({
//     super.key,
//     required this.image,
//   });
//   final Image image;

//   @override
//   State<ImageCropBody> createState() => _ImageCropBodyState();
// }

// class _ImageCropBodyState extends State<ImageCropBody> {
//   late CropController _controller;
//   Image? croppedImage;

//   @override
//   void initState() {
//     _controller = CropController(
//       aspectRatio: 1,
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           children: [
//             croppedImage != null
//                 ? Expanded(
//                     child: ListView.builder(
//                         itemCount: 10,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => const NextPage()));
//                             },
//                             child: const SizedBox(
//                                 height: 100,
//                                 child: CroppedImage(
//                                     image:
//                                         'https://firebasestorage.googleapis.com/v0/b/flutter-achieve.appspot.com/o/avatars?alt=media&token=6797816a-bc63-4066-a9ac-2de4ff9b54af')),
//                           );
//                         }),
//                   )
//                 : const SizedBox(),
//             Expanded(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxHeight: MediaQuery.of(context).size.height * 0.3,
//                     ),
//                     child: CropImage(
//                       /// Only needed if you expect to make use of its functionality like setting initial values of
//                       /// [aspectRatio] and [defaultCrop].
//                       controller: _controller,

//                       /// The image to be cropped. Use [Image.file] or [Image.network] or any other [Image].
//                       image: widget.image,

//                       /// The crop grid color of the outer lines. Defaults to 70% white.
//                       gridColor: Colors.transparent,

//                       /// The crop grid color of the inner lines. Defaults to [gridColor].
//                       gridInnerColor: Colors.transparent,

//                       /// The crop grid color of the corner lines. Defaults to [gridColor].
//                       gridCornerColor: borderBlueColor,

//                       /// The size of the corner of the crop grid. Defaults to 25.
//                       gridCornerSize: 50,

//                       /// The width of the crop grid thin lines. Defaults to 2.
//                       gridThinWidth: 1,

//                       /// The width of the crop grid thick lines. Defaults to 5.
//                       gridThickWidth: 6,

//                       /// The crop grid scrim (outside area overlay) color. Defaults to 54% black.
//                       scrimColor: scaffoldBackground.withOpacity(0.7),

//                       /// True: Always show third lines of the crop grid.
//                       /// False: third lines are only displayed while the user manipulates the grid (default).
//                       alwaysShowThirdLines: false,

//                       /// The minimum pixel size the crop rectangle can be shrunk to. Defaults to 100.
//                       minimumImageSize: 50,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             TextAndGreenButtons(
//                 textPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 greenPressed: () async {
//                   LoadingScreen.instance()
//                       .show(context: context, text: 'Обработка изображения');
//                   final Image image = await _controller.croppedImage();
//                   LoadingScreen.instance().hide();
//                   setState(() {
//                     croppedImage = image;
//                   });
//                 },
//                 blueText: 'Назад',
//                 greenText: 'Принять')
//           ],
//         ));
//   }
// }

// class NextPage extends StatelessWidget {
//   const NextPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Next Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const NextPage()));
//             },
//             child: const Text('next page')),
//       ),
//     );
//   }
// }

// class CroppedImage extends StatefulWidget {
//   const CroppedImage({super.key, required this.image});
//   final String image;

//   @override
//   State<CroppedImage> createState() => _CroppedImageState();
// }

// class _CroppedImageState extends State<CroppedImage> {
//   late Stream<Uint8List> _imageFileStream;

//   @override
//   void initState() {
//     super.initState();
//     _imageFileStream = Rx.fromCallable(() async {
//       final file = await DefaultCacheManager().getSingleFile(widget.image);
//       final uiImage = await decodeImageFromList(file.readAsBytesSync());

//       final bytes =
//           await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
//       return bytes!.buffer.;
//     });
//   }

//   @override
//   void setState(VoidCallback fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       return StreamBuilder(
//           stream: _imageFileStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return const SizedBox();
//             }

//             return Stack(
//               fit: StackFit.expand,
//               children: [
//                 FittedBox(
//                     fit: BoxFit.fill,
//                     child: snapshot.data != null
//                         ? Image.memory(snapshot.data!)
//                         : const SizedBox())
//               ],
//             );
//           });
//     });
//   }
// }

// static Future<ui.Image> getCroppedBitmap({
//     final ui.FilterQuality quality = FilterQuality.high,
//     required final Rect crop,
//     required final CropRotation rotation,
//     required final ui.Image image,
//   }) async {
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);

//     final bool tilted = rotation.isSideways;
//     final double cropWidth;
//     final double cropHeight;
//     if (tilted) {
//       cropWidth = crop.width * image.height;
//       cropHeight = crop.height * image.width;
//     } else {
//       cropWidth = crop.width * image.width;
//       cropHeight = crop.height * image.height;
//     }
//     // factor between the full size and the maxSize constraint.
//     double factor = 1;

//     final Offset cropCenter = rotation.getRotatedOffset(
//       crop.center,
//       image.width.toDouble(),
//       image.height.toDouble(),
//     );

//     final double alternateWidth = tilted ? cropHeight : cropWidth;
//     final double alternateHeight = tilted ? cropWidth : cropHeight;

//     canvas.drawImageRect(
//       image,
//       Rect.fromCenter(
//         center: cropCenter,
//         width: alternateWidth,
//         height: alternateHeight,
//       ),
//       Rect.fromLTWH(
//         0,
//         0,
//         alternateWidth * factor,
//         alternateHeight * factor,
//       ),
//       Paint()..filterQuality = quality,
//     );

//     if (rotation != CropRotation.up) {
//       canvas.restore();
//     }

//     //FIXME Picture.toImage() crashes on Flutter Web with the HTML renderer. Use CanvasKit or avoid this operation for now. https://github.com/flutter/engine/pull/20750
//     return await pictureRecorder
//         .endRecording()
//         .toImage((cropWidth * factor).round(), (cropHeight * factor).round());
//   }


// class ImagePainter extends CustomPainter {
//   @override
//   void paint(ui.Canvas canvas, ui.Size size) {
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);

//     final bool tilted = rotation.isSideways;
//     final double cropWidth;
//     final double cropHeight;
//     if (tilted) {
//       cropWidth = crop.width * image.height;
//       cropHeight = crop.height * image.width;
//     } else {
//       cropWidth = crop.width * image.width;
//       cropHeight = crop.height * image.height;
//     }
//     // factor between the full size and the maxSize constraint.
//     double factor = 1;

//     final Offset cropCenter = rotation.getRotatedOffset(
//       crop.center,
//       image.width.toDouble(),
//       image.height.toDouble(),
//     );

//     final double alternateWidth = tilted ? cropHeight : cropWidth;
//     final double alternateHeight = tilted ? cropWidth : cropHeight;
    

//     canvas.drawImageRect(
//       image,
//       Rect.fromCenter(
//         center: cropCenter,
//         width: alternateWidth,
//         height: alternateHeight,
//       ),
//       Rect.fromLTWH(
//         0,
//         0,
//         alternateWidth * factor,
//         alternateHeight * factor,
//       ),
//       Paint()..filterQuality = quality,
//     );

//     if (rotation != CropRotation.up) {
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
  
// }