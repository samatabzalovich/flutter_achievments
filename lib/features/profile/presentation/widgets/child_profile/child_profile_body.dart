import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart'
    show
        CupertinoDatePicker,
        CupertinoDatePickerMode,
        CupertinoTextThemeData,
        CupertinoTheme,
        CupertinoThemeData;
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/blue_green_buttons.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/auth/presentation/pages/sign_up/sign_up_child_page.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/choose_type_butons.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/avatar_page.dart';
import 'package:flutter_achievments/core/common/widgets/custom_switch_description.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

class ChildProfileBody extends StatefulWidget {
  const ChildProfileBody({super.key});
  @override
  State<ChildProfileBody> createState() => _ChildProfileBodyState();
}

class _ChildProfileBodyState extends State<ChildProfileBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final FocusNode focusNode = FocusNode();
  String name = '';
  DateTime dateOfBirth = DateTime.now();
  Role? selectedRole;
  bool isKidWithoutPhone = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200)); // for button animation
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _isButtonEnabled() {
    if (name.isNotEmpty && selectedRole != null) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _changeButtonColor(Role type) {
    setState(() {
      if (selectedRole != type) {
        selectedRole = type;
      } else {
        selectedRole = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 60, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomText.darkBlueTitle(LocaleKeys.adding_a_child),
          const SizedBox(height: 30),
          CustomTextField(
              labelText: '${LocaleKeys.name.tr()}:',
              focusNode: focusNode,
              inputType: TextInputType.name,
              onChanged: (value) {
                name = value;
                _isButtonEnabled();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return false;
                }
                return true;
              },
              onSubmitted: (value) {
                focusNode.unfocus();
                name = value;
                _isButtonEnabled();
              },
              isPassword: false),
          const SizedBox(height: 30),
          ChooseTypeButtons(
              firstType: Role.son,
              secondType: Role.daughter,
              firstTypeSelected: (type) {
                _changeButtonColor(type);
                _isButtonEnabled();
              },
              secondTypeSelected: (type) {
                _changeButtonColor(type);
                _isButtonEnabled();
              },
              selectedType: selectedRole),
          const SizedBox(height: 30),
          const CustomText.darkBlueTitle(LocaleKeys.birth_date),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: darkBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumYear: DateTime.now().year - 18,
                  maximumYear: DateTime.now().year,
                  initialDateTime: dateOfBirth,
                  onDateTimeChanged: (date) {
                    dateOfBirth = date;
                  }),
            ),
          ),
          const SizedBox(height: 50),
          CustomSwitchDescription(
            onChanged: (value) {
              isKidWithoutPhone = value;
            },
            paragraphFirst: LocaleKeys.if_it_is_on_kid_no_phone,
            paragraphSecond: LocaleKeys.when_kid_gets_phone,
            description: LocaleKeys.kid_without_phone,
          ),
          const Spacer(),
          AnimatedTextAndGreenButtons(
              textPressed: () {},
              greenPressed: () {
                final child = ChildEntity(
                    id: '',
                    email: '',
                    userType: UserType.child,
                    birthDate: dateOfBirth,
                    createdAt: DateTime.now(),
                    name: name,
                    withoutPhone: isKidWithoutPhone,
                    parentId: Provider.of<UserProvider>(context, listen: false)
                        .currentUser
                        ?.id,
                    role: selectedRole,
                  );
                if (isKidWithoutPhone) {
                  Navigator.of(context).pushNamed(AvatarPage.routeName,
                      arguments: {
                        'user': child,
                        'navBarTitle': LocaleKeys.kids_avatar,
                      });
                } else {
                  Navigator.of(context).pushNamed(SignUpChildPage.routeName,
                      arguments: child);
                }
              },
              blueText: LocaleKeys.skip,
              greenText: LocaleKeys.continue_go_on,
              controller: _controller)
        ],
      ),
    );
  }
}
