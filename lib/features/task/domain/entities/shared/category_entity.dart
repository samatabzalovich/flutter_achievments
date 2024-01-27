import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';

class CategoryEntity extends Equatable{
  final String id;
  final String categoryName;
  final String? categoryDescription;
  final AvatarEntity categoryImage;
  const CategoryEntity({
    required this.id,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryImage,
  });

  @override
  List<Object?> get props => [id, categoryName, categoryDescription, categoryImage];
}
