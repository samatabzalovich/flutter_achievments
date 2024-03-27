import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/presentation/pages/common/create_task_page.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseCategoryAppBar extends StatelessWidget {
  const ChooseCategoryAppBar(this.text, {super.key, this.onBackTapped});
  final String text;
  final Function(dynamic data)? onBackTapped;
  void _pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColor,
                gradientColor2,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            )),
        child: Column(
          children: [
            AppBar(
              toolbarHeight: 30,
              leading: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => _pop(context)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: CustomText(
                text,
                fontSize: 16,
                color: Colors.white,
              ),
              centerTitle: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    
                    children: [
                      _buildTaskTypeWidget(
                        svgPath: 'assets/icons/Icononce.svg',
                        onTap: () {
                          Navigator.pushNamed(context, CreateTaskPage.routeName,
                              arguments: TaskType.oneTime);
                        },
                        taskType: TaskType.oneTime.name,
                      ),
                      _buildDivider(),
                      _buildTaskTypeWidget(
                        svgPath: 'assets/icons/Iconrepeat.svg',
                        onTap: () {
                          Navigator.pushNamed(context, CreateTaskPage.routeName,
                              arguments: TaskType.repeatable);
                        },
                        taskType: TaskType.repeatable.name,
                      ),
                      _buildDivider(),
                      _buildTaskTypeWidget(
                        svgPath: 'assets/icons/Iconinfinity.svg',
                        onTap: () {
                          Navigator.pushNamed(context, CreateTaskPage.routeName,
                              arguments: TaskType.permanent);
                        },
                        taskType: TaskType.permanent.name,
                      ),
                      _buildDivider(),
                      _buildTaskTypeWidget(
                        svgPath: '',
                        onTap: () {
                          // Navigator.pushNamed(context, My.routeName, arguments: TaskType.myTemplates);
                        },
                        taskType: LocaleKeys.myTemplates,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildTaskTypeWidget({
    required String svgPath,
    required VoidCallback onTap,
    required String taskType,
  }) {
    return TextButton(
        onPressed: onTap,
        
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,

          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
    
        child: Padding(
          padding: EdgeInsets.only(
            right: 15.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              svgPath.isNotEmpty
                  ? SvgPicture.asset(
                      svgPath,
                      width: 32.w,
                      height: 32.w,
                    )
                  : Icon(
                      Icons.star_border,
                      color: lightBlue2,
                      size: 30.h,
                    ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    CustomText.darkBlueTitle(
                  taskType,
                  fontSize: 16,
                ),
                const Spacer(),
                const Icon(
                  CupertinoIcons.add,
                  color: greyColor,
                  size: 16,
                )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 40.w + 15),
      child: const Divider(
        color: greyColor,
        height: 1,
      ),
    );
  }
}
