import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_button.dart';
import 'package:flutter_achievments/features/profile/presentation/pages/choose_type_page.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});
  static const String routeName = '/terms_of_use';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar('Добро пожаловать!'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    'Если тебе не исполнилось 13 лет',
                    fontSize: 18,
                    color: redColor,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomText(
                'обратись к родителям или опекуну, чтобы они ознакомились с этой информацией.',
                fontSize: 14,
                color: redColor,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 40,
              ),
              const CustomText(
                'Пожалуйста, прочитай и прими наши Условия пользования. Они знакомят с правилами и условиями, которые ты обязуешься соблюдать, при использовании приложения. Так же прочитай нашу Политику Конфиденциальности, в которой мы описываем какие твои данные собираются и обрабатываются в Приложении.',
                fontSize: 14,
                color: darkBlue,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 19.08,
              ),
              const CustomText(
                'Спасибо!',
                color: darkBlue,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10.5,
              ),
              CustomTextButton('Политика Конфиденциальности',
                  onPressed: () {}, width: double.maxFinite, height: 48),
              const SizedBox(
                height: 16,
              ),
              CustomTextButton('Условия использования',
                  onPressed: () {}, width: double.maxFinite, height: 48),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton('Отказаться',
                      width: MediaQuery.of(context).size.width / 2.3,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 48),
                  MyElevatedButton.green(
                    height: 48,
                    width: MediaQuery.of(context).size.width / 2.3,
                    onPressed: () {
                      Navigator.of(context).pushNamed(ChooseTypePage.routeName);
                    },
                    child: const CustomText(
                      'Принять',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
