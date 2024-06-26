import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
import 'package:flutter_achievments/core/utils/screen_utilities.dart';
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
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_chat_data_source.dart';
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_task_data_source.dart';
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_task_data_source_impl.dart';
import 'package:flutter_achievments/features/task/data/repositories/chat_repo_impl.dart';
import 'package:flutter_achievments/features/task/data/repositories/task_repository_impl.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/get_chat_stream.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/get_messages.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/mark_message_seen.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/send_file_message.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/send_message.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/accept_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/attach_photo_report.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/complete_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/create_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/delete_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/get_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/redo_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/refuse_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/reject_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/suggest_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/update_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/upload_avatar.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part 'get_it.main.dart';
