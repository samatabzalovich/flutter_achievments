import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/custom_tab_bar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/date_picker_widget.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_tile.dart';

class SheetBody extends StatelessWidget {
  const SheetBody(
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
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
           CustomTabbar(
            draggableScrollableController: draggableScrollableController,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
           ),
          
          Expanded(
            child: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatePickerWidget(
                      draggableScrollableController: draggableScrollableController,
                      minChildSize: minChildSize,
                      maxChildSize: maxChildSize,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: controller,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return TaskTile(task: OneTimeTaskEntity.mock());
                          } 
                          if (index == 1) {
                            return TaskTile(task: PermanentTaskEntity.mock());
                          }
                          return TaskTile(task: RepeatableTaskEntity.mock());
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: controller,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomPaint(
                        painter: ClipShadowShadowPainter(
                          clipper: NotchedRectangleClipper(),
                        ),
                        child: ClipPath(
                          clipper: NotchedRectangleClipper(),
                          child: Container(
                            width: double
                                .infinity, // Make sure to set a width and height that works with your design
                            height: 200,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
