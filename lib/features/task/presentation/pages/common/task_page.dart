import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/custom_nav_bar_create_page.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/task_details/tassk_details_body.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class TaskPage extends StatefulWidget {
  static const String routeName = '/task-page';
  const TaskPage({super.key, required this.task});

  final TaskEntity task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late DraggableScrollableController _controller;

  @override
  void initState() {
    _controller = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxChildSize = sl<ScreenUtilities>().getMaxChildSize(context);
    final minChildSize = sl<ScreenUtilities>().getMaxChildSize(context);

    return Scaffold(
        body: Stack(
      children: [
        const CreatePageCustomNavBar(text: LocaleKeys.checking),
        CustomBottomSheet(
            controller: _controller,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (context, scrollController) {
              return TaskDetailsBody(
                task: widget.task,
              );
            }),
      ],
    ));
  }
}
