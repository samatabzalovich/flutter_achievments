import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_details/chat_widget_for_overlay.dart';

class CustomFloatingChatbutton extends StatefulWidget {
  const CustomFloatingChatbutton({super.key, required this.task});
  final TaskEntity task;

  @override
  State<CustomFloatingChatbutton> createState() =>
      _CustomFloatingChatbuttonState();
}

class _CustomFloatingChatbuttonState extends State<CustomFloatingChatbutton>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  bool _isChatOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // Required for 'with SingleTickerProviderStateMixin'
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      // Consider using a curved animation
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 200),
      end: const Offset(0, 0),
    ).animate(_animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: lightBlue2,
        elevation: 2,
        onPressed: _toggleChatOverlay,
        child: Icon(
          _isChatOpen ? Icons.close : CupertinoIcons.chat_bubble_text_fill,
          color: Colors.white,
        ));
  }

  OverlayEntry _createOverlayEntry() {
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _toggleChatOverlay(close: true),
          child: Material(
            color: Colors.black26,
            child: AnimatedBuilder(
                animation: _animationController,
                child: ScaleTransition(
                  alignment: Alignment.bottomRight,
                  scale: _animation,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ChatWidgetForOverLay(
                      title: widget.task.title,
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      task: widget.task,
                    );
                  }),
                ),
                builder: (context, child) {
                  return Center(
                    child: Transform.translate(
                      offset: _offsetAnimation.value,
                      child: child,
                    ),
                  );
                }),
          ),
        );
      },
    );

    return overlayEntry;
  }

  void _toggleChatOverlay({bool close = false}) async {
    if (_isChatOpen || close) {
      _animationController.reverse();
      if (mounted) {
        setState(() {
          _isChatOpen = false;
        });
      } else {
        _isChatOpen = false;
      }
      _overlayEntry?.remove();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _animationController.forward();
      setState(() => _isChatOpen = true);
    }
  }
}
