import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/custom_navbar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/chat_bottom_field.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_details/chat_messages.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat-page';
  const ChatPage({super.key, required this.task,   this.onExpandTapped,  this.animationController});
  final TaskEntity task;
  final VoidCallback? onExpandTapped;
  final AnimationController? animationController;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isAnimationStarted = false;
  @override
  void initState() {
    if (widget.animationController != null) {
      widget.animationController?.addListener(() {
        if (widget.animationController!.status == AnimationStatus.forward) {
          setState(() {
            isAnimationStarted = true;
          });
        } else if (widget.animationController!.status == AnimationStatus.reverse) {
          setState(() {
            isAnimationStarted = false;
          });
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        widget.task.title,
        withTr: false,
        onBackTapped: widget.animationController == null ? null : (_) => widget.onExpandTapped!.call(),
        navbarBackButtonIncluded: widget.animationController == null,
        isAnimationStarted: isAnimationStarted,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(
                taskId: widget.task.id,
              ),
            ),
            ChatBottomField(
              chat: widget.task,
            ),
          ],
        ),
      ),
    );
  }
}
