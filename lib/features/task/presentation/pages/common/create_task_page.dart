import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/dialogs/show_error_dialog.dart';
import 'package:flutter_achievments/core/common/widgets/loading/loading_screen.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/task_bloc/task_bloc.dart'
    as bloc;
import 'package:flutter_achievments/features/task/presentation/pages/home/parent_home_page.dart';
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
            context.read<bloc.TaskCubit>().uploadAvatar(
                  taskId: state.taskId,
                  photo: photo,
                );
          } else {
            LoadingScreen.instance().hide();
            // here push and remove all routes because if we pop until there is an error bad state image clone error, we need to init images again
            //   Navigator.of(context).pushNamedAndRemoveUntil(
            //   ParentHomePage.routeName,
            //   (route) => false,
            // );
            Navigator.of(context).popUntil(ModalRoute.withName(
              ParentHomePage.routeName,
            ));
          }
        }
        if (state is bloc.TaskAvatarUploaded) {
          LoadingScreen.instance().hide();
          Navigator.of(context).pushNamedAndRemoveUntil(
            ParentHomePage.routeName,
            (route) => false,
          );
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
