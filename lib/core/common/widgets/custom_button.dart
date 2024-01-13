import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 56.0,
    this.gradient = const LinearGradient(
        colors: [gradientColor2, gradientColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0, 1.0]),
  }) : super(key: key);
  const MyElevatedButton.green({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 56.0,
    this.gradient = const LinearGradient(
        colors: [greenButtonGradient, greenButtonGradient2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0]),
  }) : super(key: key);
  const MyElevatedButton.disabled({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 56.0,
    this.gradient = const LinearGradient(
        colors: [buttonDisabledGradient2, buttonDisabledGradient],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0, 1.0]),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(40);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: buttonInnerShadowColor,
            offset: Offset(0, 3),
            blurRadius: 0,
          ),
          BoxShadow(
            color: buttonShadowColor,
            offset: Offset(0, 4),
            blurRadius: 5,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        
        style: ElevatedButton.styleFrom(
          
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          foregroundColor: Colors.white10,
        ),
        child: child,
      ),
    );
  }
}
