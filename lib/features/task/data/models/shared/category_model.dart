import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.categoryName,
    required super.categoryDescription,
    required super.categoryImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
      categoryImage: AvatarEntity.fromMap(json['categoryImage']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'categoryName': categoryName};
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      categoryName: entity.categoryName,
      categoryDescription: entity.categoryDescription,
      categoryImage: entity.categoryImage,
    );
  }
}
