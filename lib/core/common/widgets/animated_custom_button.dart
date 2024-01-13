import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/common/widgets/custom_button.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';

class AnimatedCustomButton extends StatefulWidget {
  const AnimatedCustomButton(
    this.text, {
    super.key,
    required this.controller,
    this.onPressed,
    required this.width,
    this.height = 56,
  });
  final String text;
  final VoidCallback? onPressed;
  final AnimationController controller;
  final double width;
  final double height;
  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton> {
  late Animation<Color?> _topGradient;
  late Animation<Color?> _bottomGradient;
  @override
  void initState() {
    super.initState();
    _topGradient =
        ColorTween(begin: buttonDisabledGradient, end: greenButtonGradient)
            .animate(widget.controller);
    _bottomGradient =
        ColorTween(begin: buttonDisabledGradient2, end: greenButtonGradient2)
            .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => MyElevatedButton(
          onPressed: widget.controller.isCompleted ?  widget.onPressed : null,
          height: widget.height,
          gradient: LinearGradient(
              colors: [_topGradient.value!, _bottomGradient.value!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0]),
          width: widget.width,
          child: child!),
      child: CustomText(
        widget.text,
      ),
    );
  }
}
