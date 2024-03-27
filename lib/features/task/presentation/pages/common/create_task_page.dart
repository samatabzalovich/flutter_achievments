import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/custom_nav_bar_create_page.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/custom_tab_bar_create_page.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/create_page_widgets/task_create_body.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/modal_bottom_sheet.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class CreateTaskPage extends StatefulWidget {
  static const String routeName = '/create-task';
  const CreateTaskPage({super.key, required this. selectedType});

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
    super.initState();
    _controller = DraggableScrollableController();
    _tabController = TabController(length: 3, vsync: this, initialIndex: initialIndex);
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
    return Scaffold(
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
                return TabBarView(controller: _tabController, children: const [
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
    ));
  }
}
