import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/common/widgets/social_media.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with TickerProviderStateMixin {
  late AnimationController _buttonAnimationController;
  // late AnimationController _formAnimationController;

  // late Tween<Offset> _inviteButtonsTween;
  // late Tween<Offset> _formTween;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  late double _buttonWidth;
  String _email = '';
  String _password = '';
  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _buttonAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    // _formAnimationController = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 500));
    // _inviteButtonsTween =
    //     Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero);
    // _formTween =
    //     Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0.5));

    _buttonWidth = 256;
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // _inviteButtonsBuilder(
          //     onFirstButtonPressed: () {},
          //     onSecondButtonPressed: () {},
          //     firstButtonTitle: LocaleKeys.typeCodeManually,
          //     secondButtonTitle: LocaleKeys.scanQRCode),
          _formBuilder(),
          const SizedBox(
            height: 80,
          ),
          _socialMediaBuilder(),
        ],
      ),
    );
  }

  // Widget _inviteButtonsBuilder(
  //     {required VoidCallback onFirstButtonPressed,
  //     required VoidCallback onSecondButtonPressed,
  //     required String firstButtonTitle,
  //     required String secondButtonTitle}) {
  //   return Column(
  //     children: [
  //       const CustomText.darkBlueTitle(
  //         LocaleKeys.byInviteCode,
  //       ),
  //       const SizedBox(height: 24),
  //       MyElevatedButton(
  //         onPressed: onFirstButtonPressed,
  //         width: _buttonWidth,
  //         child: CustomText(firstButtonTitle),
  //       ),
  //       const SizedBox(height: 14),
  //       MyElevatedButton(
  //         onPressed: onSecondButtonPressed,
  //         width: _buttonWidth,
  //         child: CustomText(
  //           secondButtonTitle,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _formBuilder() {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.requestFocus();
      },
      child: Column(
        children: [
          const CustomText.darkBlueTitle(
            LocaleKeys.usingSignInForm,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            labelText: LocaleKeys.email,
            focusNode: _emailFocusNode,
            onChanged: (value) {
              _email = value;
              changeButtonColor();
            },
            validator: (email) {
              return isEmailValid(email);
            },
            onSubmitted: (value) {
              _emailFocusNode.unfocus();
              _passwordFocusNode.requestFocus();
            },
            isPassword: false,
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          CustomTextField(
            labelText: LocaleKeys.password,
            focusNode: _passwordFocusNode,
            onChanged: (value) {
              _password = value;
              changeButtonColor();
            },
            validator: (value) {
              return value.length >= 6;
            },
            onSubmitted: (value) {
              _passwordFocusNode.unfocus();
            },
            isPassword: true,
            inputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          AnimatedCustomButton(
            LocaleKeys.sigIn,
            controller: _buttonAnimationController,
            width: _buttonWidth,
            onPressed: () {
              BlocProvider.of<AuthCubit>(context)
                  .signInWithEmailAndPassword(_email, _password);
            },
          ),
        ],
      ),
    );
  }

  Widget _socialMediaBuilder() {
    return const Column(
      children: [
        CustomText.darkBlueTitle(
          LocaleKeys.throughSocialNetwork,
        ),
        SizedBox(
          height: 14,
        ),
        SocialMedia(),
      ],
    );
  }

  void changeButtonColor() {
    if (isEmailValid(_email) && _password.length >= 6) {
      _buttonAnimationController.forward();
    } else {
      _buttonAnimationController.reverse();
    }
  }

  bool isEmailValid(String inputemail) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regexp = RegExp(pattern);
    return regexp.hasMatch(inputemail);
  }
}
