import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart' show Uint8List;
import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:path_provider/path_provider.dart';
class ImageUtils {
  Future<Image> loadImageIntoBytes(File image) async {
  var lst = await image.readAsBytes();
  var codec = await instantiateImageCodec(lst);
  var nextFrame = await codec.getNextFrame();
  return nextFrame.image;
}

Future<File> cropImage(Image image, Rect cropRect) async {
  var pictureRecorder = PictureRecorder();
  Canvas canvas = Canvas(pictureRecorder);
  Paint paint = Paint();

  // Draw the part of the image that we want onto the canvas
  canvas.drawImageRect(
    image,
    cropRect,
    Rect.fromPoints(Offset.zero, Offset(cropRect.width, cropRect.height)),
    paint,
  );

  // Convert the canvas to an image
  final img = await pictureRecorder.endRecording().toImage(
    cropRect.width.floor(),
    cropRect.height.floor(),
  );

  return convertImageToFile(img);
}
Future<File> convertImageToFile(Image image) async {
  // Convert ui.Image to byte data
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  // Get a temporary directory
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/image.png');

  // Write the bytes to a file
  await file.writeAsBytes(pngBytes);
  return file;
}


}