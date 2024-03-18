import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/features/app/presentation/provider/app_lifecycle_cache.dart';
import 'package:provider/provider.dart';

class CroppedImage extends StatefulWidget {
  const CroppedImage({
    super.key,
    required this.tileAvatar,
  });

  final FrameAvatarEntity tileAvatar;

  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
  CropController? _controller;
  late ImageStream _imageStream;
  late ImageStreamListener _imageStreamListener;

  @override
  void initState() {
    super.initState();
    if (widget.tileAvatar.avatar is NetworkAvatarEntity) {
      if (Provider.of<LoginLifeCycleCache>(context, listen: false)
              .getCropController(widget.tileAvatar.avatar.photoUrl) ==
          null) {
        _controller = _controller = CropController(
          aspectRatio: 1,
          defaultCrop: (widget.tileAvatar.avatar as NetworkAvatarEntity).crop,
        );
        Provider.of<LoginLifeCycleCache>(context, listen: false)
            .addCropController(widget.tileAvatar.avatar.photoUrl, _controller!);
      } else {
        _controller = Provider.of<LoginLifeCycleCache>(context, listen: false)
            .getCropController(widget.tileAvatar.avatar.photoUrl);
      }

      _imageStream = Image.network(
        widget.tileAvatar.avatar.photoUrl,
        // loadingBuilder: (context, child, loadingProgress) {
        //   if (loadingProgress == null) {
        //     return child;
        //   }
        //   return const CircularProgressIndicator();
        // },
      ).image.resolve(const ImageConfiguration());
      _imageStreamListener = ImageStreamListener((info, _) {
        setState(() {
          _controller!.image = info.image;
        });
      });
      _imageStream.addListener(_imageStreamListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_controller!.getImage() == null) {
        return const SizedBox();
      }

      return Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
              future: _controller!.croppedImage(),
              builder: (context, AsyncSnapshot<Image> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FittedBox(fit: BoxFit.fill, child: snapshot.data!);
                }
                return const SizedBox();
              })
        ],
      );
    });
  }
}

// class RectClipper extends CustomClipper<Rect> {
//   final Rect clippingRect;

//   RectClipper(this.clippingRect);

//   @override
//   Rect getClip(Size size) {
//     return clippingRect.multiply(size);
//   }

//   @override
//   bool shouldReclip(CustomClipper<Rect> oldClipper) {
//     return true;
//   }
// }

// class CropPainter extends CustomPainter {
//   final ui.Image image;
//   final Rect _rawCrop;
//   CropPainter(this.image, Rect crop) : _rawCrop = crop;
//   final Paint _paint = Paint();
//   @override
//   void paint(Canvas canvas, Size size) {
//     double targetWidth = size.width;
//     double targetHeight = size.height;
//     double offset = 0;

//     final currentCrop = _rawCrop.multiply(size);
//     Path path = Path()..addRect(currentCrop);
//     canvas.clipPath(path);
//     canvas.drawImage(image, Offset(0.0, 0.0), _paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
