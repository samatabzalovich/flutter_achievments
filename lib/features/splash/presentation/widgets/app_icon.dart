import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/splash/presentation/widgets/stars_icon.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatefulWidget {
  const AppIcon(
      {super.key,
      required this.formAnimationController,
      required this.iconAnimationController});
  final AnimationController formAnimationController;
  final AnimationController iconAnimationController;
  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  late Animation<double> _shineAnimation;
  late Animation<double> _starsAnimation;

  @override
  void initState() {
    _shineAnimation = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
        parent: widget.formAnimationController, curve: Curves.easeIn));
    _starsAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: widget.formAnimationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248, // Fixed height
      child: AnimatedBuilder(
          animation: widget.formAnimationController,
          child: Positioned(
            top: 48, // Adjust as needed
            child: Image.asset(
              'assets/icons/onboard_image.png',
              width: (289 * 3) / 4,
              fit: BoxFit.contain, // Ensure it fits within the Stack
            ),
          ),
          builder: (context, child) {
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: widget.iconAnimationController,
                      curve:
                          const Interval(0.7, 1, curve: Curves.fastOutSlowIn),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: _shineAnimation.value),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        'assets/icons/blue_shine.svg',
                        width: 312,
                        fit: BoxFit.contain, // Ensure it fits within the Stack
                      ),
                    ),
                  ),
                ),
                child!,
                Positioned(
                  top: -20 * _starsAnimation.value,
                  child: Opacity(
                      opacity: _starsAnimation.value,
                      child:
                          const StarsIcon()), // Make sure StarsIcon does not overflow
                ),
              ],
            );
          }),
    );
  }
}
