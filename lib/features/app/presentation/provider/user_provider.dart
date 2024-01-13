import 'package:flutter/material.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _user;
  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }
  UserEntity? get currentUser => _user;
}