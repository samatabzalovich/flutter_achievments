import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_svg/svg.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(
          LocaleKeys.continueWith,
          color: greyColor,
          fontSize: 16,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconBuilder('assets/icons/google.svg', onTap: () {
              print('google');
            }),
            _iconBuilder('assets/icons/facebook.svg', onTap: () {
              print('facebook');
            }),
            _iconBuilder('assets/icons/apple.svg', onTap: () async {
              // final iss = await DatetimeSetting.timeIsAuto();
              // print(iss);
            }),
            _iconBuilder('assets/icons/vkontakte.svg', onTap: () {
              print('vkontakte');
            }),
            _iconBuilder('assets/icons/twitter.svg', onTap: () {
              print('twitter');
            }),
          ],
        ),
      ],
    );
  }

  Widget _iconBuilder(String path, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(onTap: onTap, child: SvgPicture.asset(path)),
    );
  }
}
