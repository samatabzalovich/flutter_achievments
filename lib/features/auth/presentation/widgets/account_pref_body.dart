
import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/auth/presentation/widgets/account_pref_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPrefBody extends StatelessWidget {
  const AccountPrefBody({
    super.key,
    required this.userInfo,
  });

  final Map<String, dynamic> userInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30, bottom: 60
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset('assets/images/parents_filled.svg'),
          Expanded(child: AcoountPrefForm(userInfo)),
        ],
      ),
    );
  }
}
