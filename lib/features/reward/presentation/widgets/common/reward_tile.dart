import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_image_frame.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';
import 'package:flutter_achievments/features/task/presentation/pages/common/task_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardTile extends StatelessWidget {
  const RewardTile(
      {super.key,
      required this.reward,
      required this.width,
      required this.height});
  final RewardEntity reward;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    const double coeff = 0.3;
    late Color backGroundColor;
    if (_isTaskNew()) {
      backGroundColor = greenTileBackground;
    } else {
      backGroundColor = Colors.white;
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TaskPage.routeName, arguments: reward);
      },
      child: SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CustomPaint(
                painter: ClipShadowShadowPainter(
                  clipper: NotchedRectangleClipper(),
                ),
                child: ClipPath(
                  clipper: NotchedRectangleClipper(
                    startWidthCoeff: coeff,
                  ),
                  child: SizedBox(
                    height: height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child:
                                    CustomImageFrame(tileAvatar: reward.avatar),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  bool _isTaskNew() {
    return (reward.createdAt.day == DateTime.now().day &&
        (DateTime.now().hour - reward.createdAt.toLocal().hour) < 3);
  }
}

class NotchedRectangleClipper extends CustomClipper<Path> {
  final double startWidthCoeff;
  final double borderRadius;

  NotchedRectangleClipper({this.startWidthCoeff = 0.3, this.borderRadius = 15});
  @override
  Path getClip(Size size) {
    double notchWidth = 15; // Width of the notch
    double notchHeight = 13; // Height of the notch
    final startHeight = size.height * startWidthCoeff;

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, (startHeight - notchWidth),)
      ..arcToPoint(
        Offset(startWidth, size.height - notchHeight),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(startWidth + notchWidth, size.height),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      // top notch
      ..lineTo((startWidth + notchWidth), 0)
      ..arcToPoint(
        Offset(startWidth, notchHeight),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..arcToPoint(
        Offset(startWidth - notchWidth, 0),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // Returning true will cause the clip to be recalculated on repaint
  }
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow = const BoxShadow(
    color: blueTileShadow,
    offset: Offset(0, 2), // Horizontal and vertical offset
    blurRadius: 5.0,
  );
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
