import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/common/widgets/cropped_image.dart';
import 'package:flutter_achievments/core/common/widgets/custom_hexagon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageFrame extends StatelessWidget {
  final FrameAvatarEntity tileAvatar;
  final double? size;
  final double? innerSize;
  const CustomImageFrame({
    super.key,
    required this.tileAvatar,
     this.size ,
     this.innerSize
  });

  @override
  Widget build(BuildContext context) {
    return CustomHexagon(
      size: size ?? 116.h,
      backgroundColor: tileAvatar.backgroundColor,
      child: RepaintBoundary(
        child: CustomHexagon(
          size:innerSize ?? 90.h,
          backgroundColor: tileAvatar.backgroundColor,
          child: CroppedImage(
            avatar: tileAvatar.avatar,
          ),
        ),
      ),
    );
  }
}
