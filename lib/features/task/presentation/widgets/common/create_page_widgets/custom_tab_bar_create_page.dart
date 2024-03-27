
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBarCreatePage extends StatelessWidget {
  const CustomTabBarCreatePage({
    super.key,
    required this.topMargin,
    required this.tabController,
  });

  final double topMargin;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final height = 46.h;
    final innerPadding = height  - 42.h;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(height: topMargin - (height/2)),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 22.w),
            child: SizedBox(
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                child: Padding(
                  padding:  EdgeInsets.all(innerPadding),
                  child: TabBar(
                    controller: tabController,
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      
                        fontSize: ScreenUtil().setSp(
                            11 * sl<ScreenUtilities>().customScaleFactor(context)),
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
                        text: LocaleKeys.oneTime.tr(),
                      ),
                      Tab(
                        text: LocaleKeys.repeatable.tr(),
                      ),
                      Tab(
                        text: LocaleKeys.permanent.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
