import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

class SelectedUserProvider extends ChangeNotifier {
  UserEntity? _selectedUser;

  UserEntity? get selectedUser => _selectedUser;

  void setSelectedUser(UserEntity? user) {
    _selectedUser = user;
    notifyListeners();
  }
}