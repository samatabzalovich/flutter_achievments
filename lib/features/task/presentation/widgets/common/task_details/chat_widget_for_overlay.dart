import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/pages/chat/chat_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatWidgetForOverLay extends StatefulWidget {
  const ChatWidgetForOverLay(
      {super.key, required this.task, required this.size, required this.title});
  final TaskEntity task;
  final String title;

  final Size size;

  @override
  State<ChatWidgetForOverLay> createState() => _ChatWidgetForOverLayState();
}

class _ChatWidgetForOverLayState extends State<ChatWidgetForOverLay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandWidthAnimation;
  late Animation<double> _expandHeightAnimation;
  @override
  void initState() {
    super.initState();
    final size = widget.size;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _expandWidthAnimation = Tween<double>(begin: 370.w, end: size.width)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
    _expandHeightAnimation = Tween<double>(begin: 300.h, end: size.height)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: ClipRRect(
              borderRadius: BorderRadius.circular(
                _animationController.isCompleted ? 0 : 20,
              ),
              child: ChatPage(
                task: widget.task,
                animationController: _animationController,
                onExpandTapped: () {
                  if (_animationController.isCompleted) {
                    _animationController.reverse();
                  } else {
                    _animationController.forward();
                  }
                },
              ),
            ),
        builder: (context, child) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: _expandHeightAnimation.value,
              maxWidth: _expandWidthAnimation.value,
            ),
            child: child,
            
          );
        });
  }
}
