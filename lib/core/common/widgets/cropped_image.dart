import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';

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
  @override
  Widget build(BuildContext context) {
    late final Widget child;
    if (widget.avatar is NetworkAvatarEntity) {
      child = Image.network(
        (widget.avatar as NetworkAvatarEntity).photoUrl,
        fit: BoxFit.fill,
      );
    } else if (widget.avatar is AssetAvatarEntity) {
      child = Image.asset(
        (widget.avatar as AssetAvatarEntity).photoUrl,
        fit: BoxFit.fill,
      );
    } else {
      child = const SizedBox();
    }
    return Stack(
      fit: StackFit.expand,
      children: [child],
    );
  }
}
