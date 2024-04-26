import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/custom_tab_bar.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/date_picker_widget.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_tile.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_tile_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSheetBody extends StatelessWidget {
  const HomeSheetBody(
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
                      draggableScrollableController:
                          draggableScrollableController,
                      minChildSize: minChildSize,
                      maxChildSize: maxChildSize,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        int itemCount = 10;
                        List<TaskEntity> tasks = [];
                        if (state is TaskLoaded) {
                          itemCount = state.tasks.length + 1;
                          tasks = state.tasks;
                        }
                        if (state is TaskError) {
                          // TODO: error block
                        }
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: controller,
                            itemCount: itemCount,
                            // physics: tasks.isNotEmpty
                            //     ? const AlwaysScrollableScrollPhysics()
                            //     : const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == itemCount - 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 50, top: 20),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox(
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration:
                                                BoxDecoration(color: greyColor),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_up,
                                          color: greyColor,
                                        ),
                                        onPressed: () {
                                          controller.animateTo(
                                              controller
                                                  .position.minScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        },
                                      ),
                                      const Expanded(
                                        child: SizedBox(
                                          height: 1,
                                          child: DecoratedBox(
                                            decoration:
                                                BoxDecoration(color: greyColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              if (tasks.isNotEmpty) {
                                return TaskTile(
                                  task: tasks[index],
                                );
                              }

                              return const TaskTileLoading();
                            },
                          ),
                        );
                      },
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
