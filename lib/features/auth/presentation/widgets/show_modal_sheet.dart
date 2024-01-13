import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';


showCustomSheet(BuildContext context,
    {required String paragraph1, required String paragraph2}) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -1),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: SizedBox(
                      height: 4,
                      width: 80,
                      child: ColoredBox(
                        color: borderBlueColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText.darkBlueTitle(
                    paragraph1,
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText.darkBlueTitle(
                    paragraph2,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ));
}
