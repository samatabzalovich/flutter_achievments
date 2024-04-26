import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text_field.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/send_message.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_bloc_provider.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SendMessageBar extends StatefulWidget {
  const SendMessageBar(
      {super.key,
      required this.chat,
      this.onInitController,
      required this.onShowEmoji,
      this.onInit});

  final Function(bool) onShowEmoji;
  final Function(FocusNode)? onInit;
  final TaskEntity chat;
  final Function(TextEditingController)? onInitController;

  @override
  State<SendMessageBar> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar>
    with SingleTickerProviderStateMixin {
  late final FocusNode focusNode;
  bool isTextMessage = false;
  bool isRecording = false;
  bool isShowEmoji = false;
  bool isRecorderInit = false;
  late AnimationController _animationController;
  late Animation _colorTween;
  FlutterSoundRecorder? _flutterSoundRecorder;
  late TextEditingController _textEditingController;
  late ChatBloc _chatBloc;

  void openAudio() async {
    await _flutterSoundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  @override
  void initState() {
    super.initState();
    _flutterSoundRecorder = FlutterSoundRecorder();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _colorTween = ColorTween(begin: lightBlue2, end: redColor)
        .animate(_animationController);
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isTextMessage = true;
        });
      } else {
        setState(() {
          isTextMessage = false;
        });
      }
    });
    openAudio();
    widget.onInit?.call(focusNode);
    _chatBloc = Provider.of<ChatBlocProvider>(context, listen: false).chatBloc!;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void sendTextMessage() async {
    if (isTextMessage) {
      _sendTextMessage();
      setState(() {
        _textEditingController.clear();
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _flutterSoundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _flutterSoundRecorder!.startRecorder(toFile: path);
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    // TODO: send file message
  }

  void selectImage() async {
    File? image = await sl<ImageUtils>().pickImage(ImageSource.gallery);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await sl<ImageUtils>().pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                border: true,
                labelText: LocaleKeys.typeMessage,
                focusNode: focusNode,
                onChanged: (val) {},
                onInit: (controller) {
                  _textEditingController = controller;
                  widget.onInitController?.call(controller);
                },
                validator: (_) {
                  return true;
                },
                borderRadius: 77.r,
                prefixIcon: IconButton(
                    onPressed: () {
                      isShowEmoji = !isShowEmoji;
                      widget.onShowEmoji(isShowEmoji);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/smiley.svg',
                      width: 36.h,
                      height: 36.h,
                      fit: BoxFit.scaleDown,
                    )),
                onSubmitted: (_) {},
                isPassword: false),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onLongPress: () {
              HapticFeedback.lightImpact();
              if (!isTextMessage) {
                setState(() {
                  isRecording = true;
                });
              }
            },
            onLongPressStart: (_) {
              HapticFeedback.lightImpact();
              if (!isTextMessage) {
                _animationController.forward();
              }
            },
            onLongPressEnd: (_) {
              _animationController.reverse();
              setState(() {
                isRecording = false;
              });
            },
            onTap: () {
              sendTextMessage();
            },
            child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) {
                return SizedBox(
                  width: 56.h,
                  height: 56.h,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _colorTween.value,
                        borderRadius: BorderRadius.circular(56.r),
                      ),
                      child: child),
                );
              },
              child: Icon(
                isTextMessage ? Icons.send : CupertinoIcons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendTextMessage() {
    _chatBloc.sendMessageSink.add(SendMessageParams(
        members: [widget.chat.parentId, ...widget.chat.children],
        message: MessageEntity(
            senderId: '',
            recieverId: widget.chat.id,
            text: _textEditingController.text,
            type: MessageEnum.text,
            timeSent: DateTime.now(),
            messageId: '',
            isSeen: false,
            repliedMessage: '',
            repliedTo: '',
            repliedMessageType: MessageEnum.text,
            taskStateMessageType: TaskStateMessageType.plain),
        chatId: widget.chat.id));
  }
}
