
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/sign_up_widgets/choose_type_radio.dart';


class ChooseTypeBody extends StatelessWidget {
  const ChooseTypeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.darkBlueTitle(
                'Давай знакомиться!',
              ),
            ],
          ),
          
          Expanded(child: ChooseTypeRadio())
        ],
      ),
    );
  }
}
