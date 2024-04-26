import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_no_tr.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/video_players.dart';

class DisplayMessageContent extends StatelessWidget {
  final String message;
  final MessageEnum messageEnum;
  final bool isMe;
  const DisplayMessageContent(
      {super.key,
      required this.message,
      required this.messageEnum,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    return messageEnum == MessageEnum.text
        ? CustomTextNoTr(
            message,
            fontSize: 14,
            textAlign:  TextAlign.start,
            fontWeight: FontWeight.w600,
            color: isMe ? darkBlue : Colors.white,
          )
        : messageEnum == MessageEnum.audio
            ? StatefulBuilder(builder: (context, setState) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        minWidth: 100,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          await audioPlayer.play(UrlSource(message));
                          setState(() {
                            isPlaying = true;
                          });
                        }
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                      ),
                    ),
                    Container(),
                  ],
                );
              })
            : messageEnum == MessageEnum.video
                ? VideoPlayerItem(videoUrl: message)
                : messageEnum == MessageEnum.gif
                    ? Image.network(message)
                    : Image.network(message);
  }
}
