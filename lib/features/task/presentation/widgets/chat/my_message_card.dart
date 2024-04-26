import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/display_message_content.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliesText;
  final String userName;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    super.key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedMessageType,
    required this.repliesText,
    required this.userName,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = repliesText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: (_) {
        onLeftSwipe();
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text //TODO: hour is not fitting well when there is one character
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5, top: 5, right: 5, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isReplying) ...[
                        CustomTextNoTr(
                          userName,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.right,
                          color: greyColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: darkBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: DisplayMessageContent(
                              message: repliesText,
                              messageEnum: repliedMessageType,
                              isMe: false),
                        ),
                        const SizedBox(height: 8),
                      ],
                      DisplayMessageContent(
                          message: message, messageEnum: type, isMe: true),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      CustomTextNoTr(
                        date,
                        textAlign: TextAlign.left,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: greyColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isSeen ? Icons.done_all : Icons.done,
                        size: 20,
                        color: isSeen ? lightBlue : greyColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
