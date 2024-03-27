import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.onTabSelected});
  final Function(int) onTabSelected;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: ClipPath(
        clipper: _MyClipper(80),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColor, // Start color
                gradientColor2, // End color
              ],
              stops: [0.0, 0.6094], // Start at 0%, end at 60.94%
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: BottomAppBar(
            height: 60.h,
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildTabItem(
                    index: 0,
                    svgPath: selectedTab == 0
                        ? 'assets/icons/calendar_bottom_active.svg'
                        : 'assets/icons/calendar_bottom.svg',
                  ),
                  _buildTabItem(
                    index: 1,
                    svgPath: selectedTab == 1
                        ? 'assets/icons/prize_active.svg'
                        : 'assets/icons/prize.svg',
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  _buildTabItem(
                    index: 2,
                    svgPath: 'assets/icons/stat.svg',
                  ),
                  _buildTabItem(
                    index: 3,
                    svgPath: 'assets/icons/envelope.svg',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String svgPath,
  }) {
    return GestureDetector(
      onTap: () {
        if (index != selectedTab) {
          setState(() {
            selectedTab = index;
            widget.onTabSelected(index);
          });
        }
      },
      child: SvgPicture.asset(
        svgPath,
        width: 48.w,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  final double space;

  _MyClipper(this.space);

  @override
  Path getClip(Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfSpace = space / 2;
    final curve = space / 15;
    final height = halfSpace / 1.15;
    path.lineTo(halfWidth - halfSpace, 0);
    path.cubicTo(halfWidth - halfSpace, 0, halfWidth - halfSpace + curve,
        height, halfWidth, height);

    path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height,
        halfWidth + halfSpace, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
