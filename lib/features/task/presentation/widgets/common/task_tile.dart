import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_image_frame.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    const double coeff = 0.3;
    late Color backGroundColor;
    if (task.createdAt.day == DateTime.now().day) {
      backGroundColor = greenTileBackground;
    } else {
      backGroundColor = Colors.white;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 17.w),
          child: CustomPaint(
            painter: ClipShadowShadowPainter(
              clipper: NotchedRectangleClipper(),
            ),
            child: ClipPath(
              clipper: NotchedRectangleClipper(
                startWidthCoeff: coeff,
              ),
              child: SizedBox(
                height: 140.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomImageFrame(tileAvatar: task.avatar),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextNoTr.darkBlueTitle(
                                task.title,
                                fontSize: 16,
                              ),
                              CustomTextNoTr.darkBlueTitle(
                                task.title,
                                fontSize: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildTaskStateWidget(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      CustomTextNoTr.darkBlueTitle(
                                        '+${task.reward.toString()}',
                                        fontSize: 16,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset('assets/icons/gem.svg',
                                          width: 20.w, height: 25.h)
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildTaskStateWidget() {
    Widget? taskSkippedWidget;
    if (task is RepeatableTaskEntity) {
      // taskSkippedWidget =
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 110.w,
          height: 25.h,
          child: Builder(builder: (context) {
            String stateName = task.state.name;
            late Color backGroundColor;
            late Color textColor;
            if (task.createdAt.day == DateTime.now().day) {
              backGroundColor = greenButtonGradient2;
              textColor = Colors.white;
              stateName = LocaleKeys.newTaskState;
            } else {
              switch (task.state) {
                case TaskStateEnum.active:
                  backGroundColor = scaffoldBackground;
                  textColor = greyColor;
                case TaskStateEnum.refused:
                case TaskStateEnum.redo:
                case TaskStateEnum.rejected:
                  backGroundColor = scaffoldBackground;
                  textColor = redColor;
                case TaskStateEnum.completed:
                  backGroundColor = lightBlue;
                  textColor = Colors.white;
                case TaskStateEnum.suggested:
                  backGroundColor = greenButtonGradient2;
                  textColor = Colors.white;
                case TaskStateEnum.pending:
                  backGroundColor = scaffoldBackground;
                  textColor = gradientColor2;
              }
            }
            return DecoratedBox(
              decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: CustomText(
                  stateName,
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            );
          }),
        ),
      ],
    );
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
    final startWidth = size.width * startWidthCoeff;

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo((startWidth - notchWidth), size.height)
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
