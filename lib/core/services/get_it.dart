import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/features/splash/data/datasources/splash_data_source.dart';
import 'package:flutter_achievments/features/splash/data/repositories/splash_repo_impl.dart';
import 'package:flutter_achievments/features/splash/domain/repositories/splash_repo.dart';
import 'package:flutter_achievments/features/splash/domain/usecases/auth_state.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_it.main.dart';
