import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/parent_profile/account_pref_form.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AccountPrefBody extends StatelessWidget {
  const AccountPrefBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 60,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset('assets/images/parents_filled.svg'),
          const Expanded(child: AcoountPrefForm()),
        ],
      ),
    );
  }
}
