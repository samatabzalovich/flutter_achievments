import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/avatar_page.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class SignUpChildBody extends StatefulWidget {
  const SignUpChildBody(this.childProfile, {super.key});
  final ChildEntity childProfile;
  @override
  State<SignUpChildBody> createState() => _SignUpChildBodyState();
}

class _SignUpChildBodyState extends State<SignUpChildBody>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNodeFieldOne;
  late FocusNode _focusNodeFieldTwo;
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

  void _isButtonEnabled() {
    if (isEmailValid(_email) && _password.length > 6) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isEmailValid(String inputemail) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regexp = RegExp(pattern);
    return regexp.hasMatch(inputemail);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CustomText.darkBlueTitle(LocaleKeys.registerChild),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            labelText: LocaleKeys.email,
            focusNode: _focusNodeFieldOne,
            onChanged: (userEmail) {
              _email = userEmail;
              _isButtonEnabled();
            },
            validator: (email) {
              final isValid = isEmailValid(email);
              return isValid;
            },
            isPassword: false,
            inputType: TextInputType.emailAddress,
            onSubmitted: (_) {
              _fieldFocusChange(
                  context, _focusNodeFieldOne, _focusNodeFieldTwo);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            validator: (password) {
              return password.length > 6;
            },
            labelText: LocaleKeys.password,
            focusNode: _focusNodeFieldTwo,
            onChanged: (password) {
              _password = password;
              _isButtonEnabled();
            },
            isPassword: true,
            onSubmitted: (password) {},
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          AnimatedTextAndGreenButtons(
              controller: _controller,
              textPressed: () {
                Navigator.of(context).pop();
              },
              greenPressed: () {
                Navigator.of(context)
                    .pushNamed(AvatarPage.routeName, arguments: {
                  'user': widget.childProfile,
                  'userCredentials': {
                    'email': _email,
                  'password': _password,
                  },
                  'navBarTitle': LocaleKeys.kids_avatar
                });
              },
              blueText: LocaleKeys.back,
              greenText: LocaleKeys.continue_go_on)
        ],
      ),
    );
  }
}
