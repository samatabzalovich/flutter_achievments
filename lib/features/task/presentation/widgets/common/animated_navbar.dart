import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/selected_child_name.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/parent_screen/dropdown.dart';

class AnimatedNavbar extends StatefulWidget {
  const AnimatedNavbar({
    super.key,
    required this.controller,
    required this.maxChildSize,
    required this.minChildSize,
  });
  final double maxChildSize;
  final double minChildSize;
  final DraggableScrollableController controller;

  @override
  State<AnimatedNavbar> createState() => _AnimatedNavbarState();
}

class _AnimatedNavbarState extends State<AnimatedNavbar>
    with TickerProviderStateMixin {
  double _opacitySelectedChild = 0.0;
  late AnimationController _animationController;
  double progress = 0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    widget.controller.addListener(() {
      double size = widget.controller.size;

      if (size == widget.minChildSize) {
        setState(() {
          _opacitySelectedChild = 0.0;
        });
      } else if (size >= widget.maxChildSize) {
        setState(() {
          _opacitySelectedChild = 1.0;
        });
      } else {
        // Calculate the opacity based on the size
        progress = (size - widget.minChildSize) / (widget.maxChildSize - widget.minChildSize);
        setState(() {
          _opacitySelectedChild = progress;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final double size =
        (height / 6) - ((height / 6) * _opacitySelectedChild) + 10;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 3],
            colors: [
              gradientColor,
              gradientColor2,
            ],
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: size,
            ),
            child: Row(
              mainAxisAlignment: _getAlignment(),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _opacitySelectedChild > 0
                    ? AnimatedOpacity(
                        opacity: _opacitySelectedChild,
                        duration: const Duration(milliseconds: 300),
                        child: const SelectedChildName(),
                      )
                    : CustomDropdown(
                        animationController: _animationController,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MainAxisAlignment _getAlignment() {
    if (widget.controller.isAttached && widget.controller.size > widget.minChildSize) {
      return MainAxisAlignment.center;
    } else {
      return MainAxisAlignment.start;
    }
  }

  Future<ui.Image> loadImage(String url) async {
    final imageProvider = NetworkImage(
      url,
    );
    final completer = Completer<ui.Image>();
    final stream = imageProvider.resolve(const ImageConfiguration());
    final listener = ImageStreamListener((ImageInfo info, _) {
      completer.complete(info.image);
    });
    stream.addListener(listener);
    return completer.future;
  }
}

class MyCustomPainter extends CustomPainter {
  final ui.Image image;
  final double left;
  final double top;
  final double right;
  final double bottom;

  MyCustomPainter(this.image,
      {required this.left,
      required this.top,
      required this.right,
      required this.bottom});

  @override
  void paint(Canvas canvas, Size size) {
    // Define the source rectangle (entire image)
    final src =
        Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble());

    // Define the destination rectangle
    final dst = Rect.fromLTRB(left, top, right, bottom);

    // Draw the image
    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
