import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required String id,
    required String categoryName,
    required String? categoryDescription,
    required AvatarEntity categoryImage,
  }) : super(
          id: id,
          categoryName: categoryName,
          categoryDescription: categoryDescription,
          categoryImage: categoryImage,
        );

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
      categoryImage: json['categoryImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName
    };
  }
}