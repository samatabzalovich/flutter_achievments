import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key, 
  required this.draggableScrollableController,  
  required this.minChildSize,
  required this.maxChildSize
  });
final DraggableScrollableController draggableScrollableController;
  final double minChildSize;
  final double maxChildSize;
  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  double _opacityTabPicker = 1.0;
  double progress = 1;
  @override
  void initState() {
    super.initState();
    widget.draggableScrollableController.addListener(() {
      double size = widget.draggableScrollableController.size;
      if (size <= widget.minChildSize) {
        setState(() {
          _opacityTabPicker = 1.0;
        });
      } else if (size >= widget.maxChildSize) {
        setState(() {
          _opacityTabPicker = 0.0;
        });
      } else {
        // Calculate the opacity based on the size
        progress = (size - widget.maxChildSize) /
            (widget.minChildSize - widget.maxChildSize);
        setState(() {
          _opacityTabPicker = progress;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
            opacity: _opacityTabPicker,
      child: Column(
        children: [
          SizedBox(
            height: 15 * _opacityTabPicker,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
                  height: _opacityTabPicker == 0 ? 0 : 48.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: SizedBox(
                height: 50.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: ScreenUtil().setSp(16 * customScaleFactor(context)),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1),
                      unselectedLabelColor: greyColor,
                      indicator: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(58, 0, 0, 0),
                              gradientColor2,
                              gradientColor
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.0, 0.08, 1.0]),
                      ),
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          text: LocaleKeys.list.tr(),
                        ),
                        Tab(
                          text: LocaleKeys.checking.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double customScaleFactor(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.shortestSide > 600;
    return isTablet ? 0.6 : 1.0; // Example adjustment, customize as needed
  }
}
