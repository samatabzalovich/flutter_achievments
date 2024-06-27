import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';
import 'package:flutter_achievments/features/reward/presentation/widgets/common/reward_tile.dart';

class RewardSheetBody extends StatelessWidget {
  const RewardSheetBody(
      {super.key,
      required this.controller,
      required this.draggableScrollableController,
      required this.minChildSize,
      required this.maxChildSize});
  final ScrollController controller;
  final DraggableScrollableController draggableScrollableController;
  final double minChildSize;
  final double maxChildSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 190,
              child: PageView.builder(
                controller: PageController(
                  initialPage: 0,
                  viewportFraction: 0.5,
                  
                ),
                itemCount: 4,
                padEnds: false,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: RewardTile(
                      reward: RewardEntity.mock(),
                      width: 400,
                      height: 190,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
