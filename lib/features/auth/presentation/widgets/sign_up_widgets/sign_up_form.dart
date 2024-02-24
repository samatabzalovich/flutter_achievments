
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';

import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter_achievments/features/auth/presentation/pages/login/login_page.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(this.userType, {super.key});
  final UserType userType;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNodeFieldOne;
  late FocusNode _focusNodeFieldTwo;
  bool disabled = true;
  bool isValidPassword = false;
  bool isValidEmail = false;
  late AnimationController _controller;
  String _email = '';
  String _password = '';
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusNodeFieldOne = FocusNode();
    _focusNodeFieldTwo = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeFieldOne.dispose();
    _focusNodeFieldTwo.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isPasswordValid(String inputpassword) => inputpassword.length >= 6;

  bool isEmailValid(String inputemail) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regexp = RegExp(pattern);
    return regexp.hasMatch(inputemail);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText.darkBlueTitle(LocaleKeys.toProtectYourData),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          labelText: LocaleKeys.email,
          focusNode: _focusNodeFieldOne,
          onChanged: (userEmail) {
            _email = userEmail;
            if (isValidEmail && isValidPassword) {
              disabled = false;
              _controller.forward();
            } else {
              disabled = true;
              _controller.reverse();
            }
          },
          validator: (email) {
            isValidEmail = isEmailValid(email);
            return isValidEmail;
          },
          isPassword: false,
          inputType: TextInputType.emailAddress,
          onSubmitted: (_) {
            _fieldFocusChange(context, _focusNodeFieldOne, _focusNodeFieldTwo);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextField(
          validator: (password) {
            isValidPassword = isPasswordValid(password);
            return isValidPassword;
          },
          labelText: LocaleKeys.password,
          focusNode: _focusNodeFieldTwo,
          onChanged: (password) {
            _password = password;
            if (isValidEmail && isValidPassword) {
              disabled = false;
              _controller.forward();
            } else {
              disabled = true;
              _controller.reverse();
            }
          },
          isPassword: true,
          onSubmitted: (password) {},
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        AnimatedCustomButton(
          LocaleKeys.register,
          controller: _controller,
          onPressed:  () {
                  context.read<AuthCubit>().signUpWithEmailAndPassword(
                      _email, _password, widget.userType);
                },
          width: MediaQuery.of(context).size.width / 1.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => route.isFirst);
            },
            child: const CustomText(
              LocaleKeys.alreadyRegistered,
              fontWeight: FontWeight.w600,
              color: borderBlueColor,
            )),
      ],
    );
  }
}
