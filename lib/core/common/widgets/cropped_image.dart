import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/app/presentation/provider/app_lifecycle_cache.dart';
import 'package:provider/provider.dart';

class CroppedImage extends StatefulWidget {
  const CroppedImage({
    super.key,
    required this.avatar,
  });

  final AvatarEntity avatar;
  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
  late CropController _controller;
  late ImageStream _imageStream;
  late ImageStreamListener _imageStreamListener;
  Image? croppedImage;

  @override
  void initState() {
    super.initState();
    if (widget.avatar is NetworkAvatarEntity) {
      if (Provider.of<LoginLifeCycleCache>(context, listen: false)
              .getCropController(widget.avatar.photoUrl) ==
          null) {
        _controller = _controller = CropController(
          aspectRatio: 1,
          defaultCrop: (widget.avatar as NetworkAvatarEntity).crop,
        );
        Provider.of<LoginLifeCycleCache>(context, listen: false)
            .addCropController(widget.avatar.photoUrl, _controller);
      } else {
        _controller = Provider.of<LoginLifeCycleCache>(context, listen: false)
            .getCropController(widget.avatar.photoUrl)!;
      }

      _imageStream = Image.network(
        widget.avatar.photoUrl,
      ).image.resolve(const ImageConfiguration());
      _imageStreamListener = ImageStreamListener((info, _) async {
        _controller.image = info.image;
        croppedImage = await _controller.croppedImage();
        setState(() {});
      });
      _imageStream.addListener(_imageStreamListener);
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (_controller.getImage() == null) {
        return const SizedBox();
      }

      return Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(fit: BoxFit.fill, child: croppedImage ?? const SizedBox())
        ],
      );
    });
  }
}
