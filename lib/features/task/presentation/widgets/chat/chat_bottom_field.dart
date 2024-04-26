// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_details/send_message_bar.dart';

class ChatBottomField extends StatefulWidget {
  const ChatBottomField({
    super.key,
    required this.chat,
  });
  final TaskEntity chat;

  @override
  State<ChatBottomField> createState() => _ChatBottomFieldState();
}

class _ChatBottomFieldState extends State<ChatBottomField> {
  bool isShowEmoji = false;
  late FocusNode focusNode;
  late TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Hero(
              tag: 'send_message_bar',
              child: Material(
                  type: MaterialType.transparency,
                  child: SendMessageBar(
                    onInit: (focusNode) {
                      this.focusNode = focusNode;
                      this.focusNode.addListener(() {
                        if (this.focusNode.hasFocus) {
                          hideEmojiContainer();
                        }
                      });
                    },
                    onInitController: (controller) {
                      _textEditingController = controller;
                    },
                    chat: widget.chat,
                    onShowEmoji: (value) {
                      toggleEmojiKeyboardContainer();
                    },
                  ))),
        ),
        isShowEmoji
            ? EmojiPicker(
              config: Config(
                emojiViewConfig: const EmojiViewConfig(
                    backgroundColor: scaffoldBackground),
                bottomActionBarConfig: BottomActionBarConfig(
                  showBackspaceButton: true,
                  backgroundColor: scaffoldBackground,
                  customBottomActionBar: (config, state, showSearchView) {
                    return Container(
                      color: scaffoldBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(lightBlue2)),
                            onPressed: () {
                              showSearchView();
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.backspace,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(redColor)),
                            onPressed: () {
                              _textEditingController.text =
                                  _textEditingController.text.characters
                                      .skipLast(1)
                                      .toString();
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black)),
                            onPressed: () {
                              hideEmojiContainer();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              onEmojiSelected: ((category, emoji) {
                _textEditingController.text =
                    _textEditingController.text + emoji.emoji;
              }),
            )
            : const SizedBox(),
      ],
    );
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmoji = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmoji = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyBoard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmoji) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyBoard();
      showEmojiContainer();
    }
  }
}
