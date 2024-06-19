import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/generated/locale_keys.g.dart';

class CategoryEntity extends Equatable {
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

  static List<CategoryEntity> defaultCategories() {
    return [
      const CategoryEntity(
        id: '1',
        categoryName: LocaleKeys.householdChores,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '2',
        categoryName: LocaleKeys.studies,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '3',
        categoryName: LocaleKeys.dailyRoutine,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '4',
        categoryName: LocaleKeys.selfDevelopment,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '5',
        categoryName: LocaleKeys.health,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '6',
        categoryName: LocaleKeys.behavioral,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '7',
        categoryName: LocaleKeys.neatness,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '8',
        categoryName: LocaleKeys.animalsAndPlants,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '9',
        categoryName: LocaleKeys.friendsAndFamily,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '10',
        categoryName: LocaleKeys.sports,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '11',
        categoryName: LocaleKeys.reading,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '12',
        categoryName: LocaleKeys.creativeThinking,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
    ];
  }

  static List<CategoryEntity> defaultRewardCategories() {
    return [
      const CategoryEntity(
        id: '1',
        categoryName: LocaleKeys.householdChores,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '2',
        categoryName: LocaleKeys.studies,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '3',
        categoryName: LocaleKeys.dailyRoutine,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '4',
        categoryName: LocaleKeys.selfDevelopment,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '5',
        categoryName: LocaleKeys.health,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '6',
        categoryName: LocaleKeys.behavioral,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '7',
        categoryName: LocaleKeys.neatness,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '8',
        categoryName: LocaleKeys.animalsAndPlants,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '9',
        categoryName: LocaleKeys.friendsAndFamily,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '10',
        categoryName: LocaleKeys.sports,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '11',
        categoryName: LocaleKeys.reading,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
      const CategoryEntity(
        id: '12',
        categoryName: LocaleKeys.creativeThinking,
        categoryDescription: '',
        categoryImage: NoneAvatarEntity(),
      ),
    ];
  }



  @override
  List<Object?> get props =>
      [id, categoryName, categoryDescription, categoryImage];
}
