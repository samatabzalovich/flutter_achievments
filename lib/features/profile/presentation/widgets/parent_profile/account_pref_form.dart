// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/widgets/animated_custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/avatar_page.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/choose_type_butons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_switch_description.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class AcoountPrefForm extends StatefulWidget {
  const AcoountPrefForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AcoountPrefForm> createState() => _AcoountPrefFormState();
}

class _AcoountPrefFormState extends State<AcoountPrefForm>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode; // for unfocus
  late AnimationController _controller;
  late ParentEntity userInfo;

  String userName = '';
  Role? role;
  bool isTypeShown = false; // show as a mom or dad

  @override
  void initState() {
    super.initState();
    userInfo = Provider.of<UserProvider>(context, listen: false).currentUser! as ParentEntity;
    _focusNode = FocusNode();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)); // for button animation
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _changeButtonColor(Role type) {
    setState(() {
      if (role != type) {
        role = type;
      } else {
        role = null;
      }
    });
  }

  void _isButtonEnabled() {
    if (userName.isNotEmpty && role != null && userName.length > 1) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: _formBuilder()),
        AnimatedCustomButton(LocaleKeys.continue_go_on, controller: _controller,
            onPressed: () {
          Navigator.of(context).pushNamed(
            AvatarPage.routeName,
            arguments: {
              'user': (userInfo).copyWith(
                name: userName,
                role: role,
                isRoleShown: isTypeShown,
              ),
              'navBarTitle': LocaleKeys.selectAvatar,
            },
          );
        }, width: MediaQuery.of(context).size.width / 1.67),
      ],
    );
  }

  Widget _formBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText.darkBlueTitle(LocaleKeys.typeYourInfo),
        const CustomText.darkBlueTitle(
          LocaleKeys.soThatFamilyRecognizesYou,
          fontSize: 16,
        ),
        CustomTextField(
            labelText: LocaleKeys.yourNameAdult,
            focusNode: _focusNode,
            onChanged: (name) {
              userName = name;
              _isButtonEnabled();
            },
            validator: (name) {
              if (name.isEmpty || name.length < 2) {
                return false;
              }
              return true;
            },
            onSubmitted: (name) {
              _focusNode.unfocus();
            },
            isPassword: false),
        const CustomText.darkBlueTitle(LocaleKeys.areYouAdultOrChild),
        ChooseTypeButtons(
            firstType: Role.mom,
            secondType: Role.dad,
            selectedType: role,
            firstTypeSelected: (type) {
              _changeButtonColor(type);
              _isButtonEnabled();
            },
            secondTypeSelected: (type) {
              _changeButtonColor(type);
              _isButtonEnabled();
            }),
        CustomSwitchDescription(
          paragraphFirst: LocaleKeys.accountPrefsFirstTitle,
          paragraphSecond: LocaleKeys.accountPrefsSecondTitle,
          description: LocaleKeys.displayAsMomOrDad,
          onChanged: (value) {
            setState(() {
              isTypeShown = value;
            });
          },
        ),
      ],
    );
  }
}
