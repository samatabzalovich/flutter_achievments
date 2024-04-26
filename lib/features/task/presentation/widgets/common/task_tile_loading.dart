import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/common/widgets/custom_image_frame.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TaskTileLoading extends StatelessWidget {
  const TaskTileLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double coeff = 0.3;
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Shimmer.fromColors(
                              baseColor: scaffoldBackground,
                              highlightColor:
                                  scaffoldBackground.withOpacity(0.1),
                              child: CustomImageFrame(
                                  tileAvatar: FrameAvatarEntity(
                                      avatar: const NoneAvatarEntity(),
                                      backgroundColor: scaffoldBackground
                                          .withOpacity(0.50))),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 10.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTaskDeadlineBlocks(),
                                _buildTitleBlock(),
                                _buildTaskStateWidget(),
                              ],
                            ),
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
    return Shimmer.fromColors(
      baseColor: scaffoldBackground,
      highlightColor: scaffoldBackground.withOpacity(0.1),
      child: SizedBox(
        width: 110.w,
        height: 25.h,
        child: Builder(builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTitleBlock() {
    return Shimmer.fromColors(
      baseColor: scaffoldBackground,
      highlightColor: scaffoldBackground.withOpacity(0.1),
      child: SizedBox(
        height: 20.h,
        width: 200.w,
        child: Builder(builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTaskDeadlineBlocks() {
    return Shimmer.fromColors(
      baseColor: scaffoldBackground,
      highlightColor: scaffoldBackground.withOpacity(0.1),
      child: SizedBox(
        height: 20.h,
        width: 100.w,
        child: Builder(builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }
}
