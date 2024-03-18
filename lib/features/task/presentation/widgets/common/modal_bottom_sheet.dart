import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/sheet_body.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet(
      {super.key,
      required this.controller,
      required this.minChildSize,
      required this.maxChildSize});
  final DraggableScrollableController controller;
  final double minChildSize;
  final double maxChildSize;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      controller: controller,
      initialChildSize: minChildSize,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: SheetBody(
            controller: scrollController,
            draggableScrollableController: controller,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
          ),
        );
      },
    );
  }
}
