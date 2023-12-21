import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/widgets/custom_text.dart';
import 'package:flutter_svg/svg.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          const CustomText(
            'Продолжить с помощью',
            color: greyColor,
            fontSize: 16,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _iconBuilder('assets/icons/google.svg', onTap: () {
                print('google');
              }),
              _iconBuilder('assets/icons/facebook.svg', onTap: () {
                print('facebook');
              }),
              _iconBuilder('assets/icons/apple.svg', onTap: () {
                print('apple');
              }),
              _iconBuilder('assets/icons/vkontakte.svg', onTap: () {
                print('vkontakte');
              }),
              _iconBuilder('assets/icons/twitter.svg', onTap: () {
                print('twitter');
              }),
            ],
          ),
          const SizedBox(height: 8),
          const CustomText(
            'Есть вопросы? Свяжитесь с нами.',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: socialMediaTextColor,
          )
        ],
      ),
    );
  }

  Widget _iconBuilder(String path, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(onTap: onTap, child: SvgPicture.asset(path)),
    );
  }
}
