import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/one_time_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/permanent_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/repeatable_task_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/task_bloc/task_bloc.dart'
    as bloc;
import 'package:flutter_achievments/features/task/presentation/provider/task_provider.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/custom_nav_bar_create_page.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/custom_tab_bar_create_page.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_create_body.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTaskPage extends StatefulWidget {
  static const String routeName = '/create-task';
  const CreateTaskPage({super.key, required this.selectedType});

  final TaskType selectedType;
  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage>
    with SingleTickerProviderStateMixin {
  late DraggableScrollableController _controller;
  late TabController _tabController;

  @override
  void initState() {
    final initialIndex = widget.selectedType == TaskType.oneTime
        ? 0
        : widget.selectedType == TaskType.repeatable
            ? 1
            : 2;

    _controller = DraggableScrollableController();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxChildSize = sl<ScreenUtilities>().getMaxChildSize(context);
    final minChildSize = sl<ScreenUtilities>().getMinChildSize(context);
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height * minChildSize;
    return BlocListener<bloc.TaskCubit, bloc.TaskState>(
      listener: (context, state) {
        if (state is bloc.TaskLoading) {
          LoadingScreen.instance().show(context: context, text: '');
        }

        if (state is bloc.TaskCreated) {
          if (state.task.avatar.avatar is NetworkAvatarEntity) {
            final photo = state.task.avatar;
            context.read<TaskProvider>().addTask(state.task, doesUiNeedsToBeUpdated: false);
            context.read<bloc.TaskCubit>().uploadAvatar(
                  task: state.task,
                  photo: photo,
                  taskId: state.taskId,
                );
          } else {
            TaskEntity task = state.task;
            switch (state.task.type) {
              case TaskType.oneTime:
                task = (task as OneTimeTaskEntity).copyWith(
                  id: state.taskId,
                );
                break;
              case TaskType.repeatable:
                task = (task as RepeatableTaskEntity).copyWith(
                  id: state.taskId,
                );
              case TaskType.permanent:
                task = (task as PermanentTaskEntity).copyWith(
                  id: state.taskId,
                );
            }
            context.read<TaskProvider>().addTask(task, doesUiNeedsToBeUpdated: true);
            LoadingScreen.instance().hide();
            
            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
          }
        }
        if (state is bloc.TaskAvatarUploaded) {
          context.read<TaskProvider>().updateTask(state.task, state.taskId);
          LoadingScreen.instance().hide();
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        if (state is bloc.TaskLoadingProress) {
          LoadingScreen.instance()
              .show(context: context, text: state.progress.toInt().toString());
        }
        if (state is bloc.TaskError) {
          LoadingScreen.instance().hide();
          showErrorDialog(
              dialogText: state.dialogTitleText,
              dialogTitle: state.dialogTitle,
              context: context);
        }
      },
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            const CreatePageCustomNavBar(text: LocaleKeys.newTask),
            CustomBottomSheet(
                controller: _controller,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                builder: (context, scrollController) {
                  return TabBarView(
                      controller: _tabController,
                      children: const [
                        TaskCreateBody(
                          taskType: TaskType.oneTime,
                        ),
                        TaskCreateBody(
                          taskType: TaskType.repeatable,
                        ),
                        TaskCreateBody(
                          taskType: TaskType.permanent,
                        ),
                      ]);
                }),
            CustomTabBarCreatePage(
                topMargin: height, tabController: _tabController),
          ],
        ),
      )),
    );
  }
}
