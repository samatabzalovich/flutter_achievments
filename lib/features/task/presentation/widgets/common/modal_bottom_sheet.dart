import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key,
      required this.controller,
      required this.minChildSize,
      required this.maxChildSize,
      required this.builder});
  final DraggableScrollableController controller;
  final double minChildSize;
  final double maxChildSize;
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      controller: controller,
      initialChildSize: minChildSize,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: builder(context, scrollController));
      },
    );
  }
}
