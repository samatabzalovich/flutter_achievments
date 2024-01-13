import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/child_profile_page.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' show pi;

class ChooseTypeRadio extends StatefulWidget {
  const ChooseTypeRadio({super.key});

  @override
  State<ChooseTypeRadio> createState() => _ChooseTypeRadioState();
}

class _ChooseTypeRadioState extends State<ChooseTypeRadio>
    with SingleTickerProviderStateMixin {
  UserType? userType;
  bool disabled = true;
  late AnimationController _controller;
  late Animation<Color?> _topGradient;
  late Animation<Color?> _bottomGradient;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _topGradient =
        ColorTween(begin: buttonDisabledGradient, end: greenButtonGradient)
            .animate(_controller);
    _bottomGradient =
        ColorTween(begin: buttonDisabledGradient2, end: greenButtonGradient2)
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child!,
          MyElevatedButton(
            onPressed: disabled
                ? null
                : () {
                    Navigator.of(context)
                        .pushNamed(SignUpPage.routeName, arguments: userType);
                  },
            gradient: LinearGradient(
                colors: [_topGradient.value!, _bottomGradient.value!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0]),
            width: MediaQuery.of(context).size.width / 1.68,
            child: const CustomText(
              LocaleKeys.continue_go_on,
            ),
          )
        ],
      ),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText.darkBlueTitle(
              LocaleKeys.areYouAdultOrChild,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    disabled = false;
                    setState(() {
                      if (userType == null || userType == UserType.child) {
                        userType = UserType.parent;
                        _controller.forward();
                      } else {
                        disabled = true;
                        userType = null;
                        _controller.reverse();
                      }
                    });
                  },
                  child: _userTypeBuilder(LocaleKeys.adult,
                      svgPath: userType == UserType.parent
                          ? 'assets/images/parents_filled.svg'
                          : null),
                ),
                GestureDetector(
                    onTap: () {
                      disabled = false;
                      setState(() {
                        if (userType == null || userType == UserType.parent) {
                          userType = UserType.child;
                          _controller.forward();
                        } else {
                          disabled = true;
                          userType = null;
                          _controller.reverse();
                        }
                      });
                    },
                    child: _userTypeBuilder(LocaleKeys.child,
                        type: UserType.child,
                        svgPath: userType == UserType.child
                            ? 'assets/images/parents_filled.svg'
                            : null)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _userTypeBuilder(String userType,
      {UserType type = UserType.parent, String? svgPath}) {
    final double rotationAngle;
    if (type == UserType.parent) {
      rotationAngle = 0;
    } else {
      rotationAngle = pi;
    }
    return Column(
      children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(rotationAngle),
            child: SvgPicture.asset(
              svgPath ?? 'assets/images/parents_outlined.svg',
              width: MediaQuery.of(context).size.width / 2.3,
            )),
        const SizedBox(
          height: 16,
        ),
        CustomText.darkBlueTitle(userType),
      ],
    );
  }
}
