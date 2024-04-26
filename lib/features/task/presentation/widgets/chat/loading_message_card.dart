import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/display_message_content.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMessageCards extends StatelessWidget {
  const LoadingMessageCards({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final isme = Random().nextBool();
    final randomPadding = Random().nextInt(50);
    return Shimmer.fromColors(
      baseColor: scaffoldBackground,
      highlightColor: Colors.black.withOpacity(0.1),
      child: Align(
        alignment: isme ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: scaffoldBackground.withOpacity(0.50),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      left: 10 + randomPadding.toDouble(),
                      right: 50 + randomPadding.toDouble(),
                      top: 5,
                      bottom: 30 + randomPadding.toDouble(),
                    ),
                    child: DisplayMessageContent(
                        message: '',
                        messageEnum: MessageEnum.text,
                        isMe: isme)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
