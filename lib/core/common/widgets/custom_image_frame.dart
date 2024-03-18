import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/common/widgets/cropped_image.dart';
import 'package:flutter_achievments/core/common/widgets/custom_hexagon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageFrame extends StatelessWidget {
  final FrameAvatarEntity tileAvatar;

  const CustomImageFrame({
    super.key,
    required this.tileAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return CustomHexagon(
      size: 110.w,
      backgroundColor: tileAvatar.backgroundColor,
      child: RepaintBoundary(
        child: CustomHexagon(
          size: 90.w,
          backgroundColor: tileAvatar.backgroundColor,
          child: CroppedImage(tileAvatar: tileAvatar),
        ),
      ),
    );
  }
}

