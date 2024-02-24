import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_achievments/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_achievments/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/register.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/sign_in.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter_achievments/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_achievments/features/profile/data/datasources/profile_remote_source.dart';
import 'package:flutter_achievments/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/create_child.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/create_child_profile.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/update_avatar.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/update_profile.dart';
import 'package:flutter_achievments/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_achievments/features/splash/data/datasources/splash_data_source.dart';
import 'package:flutter_achievments/features/splash/data/repositories/splash_repo_impl.dart';
import 'package:flutter_achievments/features/splash/domain/repositories/splash_repo.dart';
import 'package:flutter_achievments/features/splash/domain/usecases/auth_state.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

part 'get_it.main.dart';
