import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/reward/presentation/widgets/reward_sheet_body.dart';
import 'package:flutter_achievments/features/task/presentation/provider/page_index.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/home_sheet_body.dart';
import 'package:provider/provider.dart';

class TabBottomSheetWidgets extends StatelessWidget {
  const TabBottomSheetWidgets(
      {super.key,
      required this.controller,
      required this.minChildSize,
      required this.maxChildSize,
      required this.scrollController});
  final DraggableScrollableController controller;
  final double minChildSize;
  final double maxChildSize;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageIndexProvider>(builder: (context, value, _) {
      switch (value.getPageNumber) {
        case 0:
          return HomeSheetBody(
            controller: scrollController,
            draggableScrollableController: controller,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
          );
        case 1:
          return RewardSheetBody(
            controller: scrollController,
            draggableScrollableController: controller,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
          );
        case 2:
          return Container();
        default:
          return Container();
      }
    });
  }
}
