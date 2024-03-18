
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/avatar_type.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarBuilder extends StatelessWidget {
  const AvatarBuilder(this._userName, {this.width = 98,this.avatarEntity, super.key});
  final AvatarEntity? avatarEntity;
  final double width;
  final String _userName;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:  BorderRadius.all(Radius.circular(width)),
      child: ColoredBox(
        color: getRandomColor(),
        child: SizedBox(
          width: ScreenUtil().setWidth(width),
          height: ScreenUtil().setWidth(width),
          child: Center(
            child: avatarEntity == null || avatarEntity is NoneAvatarEntity
            ? CustomText(
                    formatName(_userName),
                    fontSize: 20,
                  )
                : _avatarBuilder(avatarEntity!),
          ),
        ),
      ),
    );
  }

  String formatName(String userName) {
    String formattedName = '';
    formattedName = userName[0].toUpperCase();
    formattedName += userName.substring(1, 2).toLowerCase();
    return formattedName;
  }

  Color getRandomColor() {
    Color color;
    do {
      color = Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));
    } while (_isColorBright(color));
    return color;
  }

  bool _isColorBright(Color color) {
    // Calculate the perceived brightness of the color
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness > 150; // You can adjust this threshold as needed
  }

  Widget _avatarBuilder(AvatarEntity avatar) {
    switch (avatar.type) {
      case AvatarType.asset:
        return Image.asset(
          avatar.photoUrl,
          fit: BoxFit.cover,
        );
      case AvatarType.network:
        if (avatar is NetworkAvatarEntity && avatar.image != null) {
          return avatar.image!;
        } 
          return Image.network(
            avatar.photoUrl,
            fit: BoxFit.cover,
          );
        
      default:
        return Image.asset(
          avatar.photoUrl,
          fit: BoxFit.cover,
        );
    }
  }
}
