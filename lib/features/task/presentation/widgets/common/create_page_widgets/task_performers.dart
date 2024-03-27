// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/widgets/avatar_builder.dart';
import 'package:flutter_achievments/core/common/widgets/custom_text.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/profile/presentation/widgets/common/custom_switch_description.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TaskPerformers extends StatefulWidget {
  const TaskPerformers({
    Key? key,
    required this.onPerformersSelected,
  }) : super(key: key);
  final Function(List<ChildEntity> performers, bool isCommonTask)
      onPerformersSelected;

  @override
  State<TaskPerformers> createState() => _TaskPerformsState();
}

class _TaskPerformsState extends State<TaskPerformers> {
  late PageController _controller;
  List<ChildEntity> selectedChildren = [];
  bool isCommonTask = false;
  late List<ChildEntity> children;
  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.25,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    children = (Provider.of<UserProvider>(context, listen: true).currentUser!
                as ParentEntity)
            .children ??
        [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText.darkBlueTitle(LocaleKeys.performers),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedChildren.clear();
                    widget.onPerformersSelected(selectedChildren, isCommonTask);
                  });
                },
                child: const CustomText(
                  LocaleKeys.removeSelected,
                  fontSize: 14,
                  color: lightBlue2,
                ))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        _buildSelectPerformer(),
        CustomSwitchDescription(onChanged: (value) {
          setState(() {
            isCommonTask = value;
            widget.onPerformersSelected(selectedChildren, isCommonTask);
          });
        }, paragraphFirst: LocaleKeys.commonTaskDescription, paragraphSecond: '', description: LocaleKeys.commonTask)
      ],
    );
  }

  Widget _buildSelectPerformer() {
    if (children.isNotEmpty) {
      return SizedBox(
        height: 120.h,
        child: PageView.builder(
            padEnds: false,
            controller: _controller,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedChildren.contains(children[index])) {
                      selectedChildren.remove(children[index]);
                    } else {
                      selectedChildren.add(children[index]);
                    }
                    widget.onPerformersSelected(selectedChildren, isCommonTask);
                  });
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        AvatarBuilder(
                          children[index].name!,
                          width: 80,
                          avatarEntity: children[index].avatar,
                        ),
                        if (selectedChildren.isNotEmpty &&
                            selectedChildren.contains(children[index]))
                          const Positioned(
                            right: 0,
                            bottom: 0,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenButtonGradient2,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomText.darkBlueTitle(
                      children[index].name!,
                      fontSize: 14,
                    )
                  ],
                ),
              );
            }),
      );
    } else {
      return const SizedBox();
    }
  }
}
