import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/common/choose_category_app_bar.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseCategoryTaskPage extends StatelessWidget {
  static const String routeName = '/choose-category-task';
  const ChooseCategoryTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultCategories = CategoryEntity.defaultCategories();
    return Scaffold(
      body: Column(
        children: [
          const ChooseCategoryAppBar(LocaleKeys.newTask),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: defaultCategories.length,
              itemBuilder: (context, index) {
                return const Text('data');
              },
            ),
          ),
        ],
      ),
    );
  }
}
