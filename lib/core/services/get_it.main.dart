part of 'get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase
  sl
        // dependencies
        ..registerLazySingleton(() => FirebaseAuth.instance)
        ..registerLazySingleton(() => FirebaseFirestore.instance)
        ..registerLazySingleton(() => FirebaseStorage.instance)
        ..registerLazySingleton(() => FirebaseFunctions.instance)
        ..registerLazySingleton(() => ImagePicker())
        // utils
        ..registerLazySingleton(() => ScreenUtilities())
        ..registerLazySingleton(() => ImageUtils(sl<ImagePicker>()))
        //data sources
        ..registerLazySingleton<AuthRemoteSource>(
            () => AuthRemoteSourceImpl(sl(), sl()))
        ..registerLazySingleton<SplashDataSource>(
            () => SplashDataSourceImpl(sl(), sl()))
        ..registerLazySingleton<ProfileRemoteSource>(
            () => ProfileRemoteSourceImpl(sl(), sl(), sl()))
        ..registerLazySingleton<RemoteTaskDataSource>(
            () => RemoteTaskDataSourceImpl(sl(), sl()))
        ..registerLazySingleton<RemoteChatDataSource>(
            () => RemoteChatDataSourceImpl(sl(), sl(), sl()))

        // usecases
        ..registerLazySingleton<AuthStateUseCase>(() => AuthStateUseCase(sl()))
        ..registerLazySingleton(() => RegisterUseCase(sl()))
        ..registerLazySingleton(() => SignInUseCase(sl()))
        ..registerLazySingleton(() => UpdateAvatarUseCase(sl()))
        ..registerLazySingleton(() => UpdateProfileUseCase(sl()))
        ..registerLazySingleton(() => CreateChildProfileUseCase(sl()))
        ..registerLazySingleton(() => CreateChildUseCase(sl()))
        ..registerLazySingleton(() => SignOutUseCase(sl()))
        ..registerLazySingleton(() => UploadAvatarUseCase(sl()))
        //taskusecases
        ..registerLazySingleton(() => GetTaskUseCase(sl()))
        ..registerLazySingleton(() => CreateTaskUseCase(sl()))
        ..registerLazySingleton(() => AcceptTaskUseCase(sl()))
        ..registerLazySingleton(() => AttachPhotoReportUseCase(sl()))
        ..registerLazySingleton(() => CompleteTaskUseCase(sl()))
        ..registerLazySingleton(() => DeleteTaskUseCase(sl()))
        ..registerLazySingleton(() => RedoTaskUseCase(sl()))
        ..registerLazySingleton(() => RefuseTaskUseCase(sl()))
        ..registerLazySingleton(() => RejectTaskUseCase(sl()))
        ..registerLazySingleton(() => SuggestTaskUseCase(sl()))
        ..registerLazySingleton(() => UpdateTaskUseCase(sl()))
        //chat use cases
        ..registerLazySingleton(() => SendMessageUseCase(sl()))
        ..registerLazySingleton(() => GetMessagesUseCase(sl()))
        ..registerLazySingleton(() => SendFileMessageUseCase(sl()))
        ..registerLazySingleton(() => MarkMessageSeenUseCase(sl()))
        ..registerLazySingleton(
          () => GetChatStreamUseCase(sl()),
        )

        // repositories
        ..registerLazySingleton<SplashRepo>(() => SplashRepoImpl(sl()))
        ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
        ..registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(sl()))
        ..registerLazySingleton<TaskRepo>(() => TaskRepoImpl(sl()))
        ..registerLazySingleton<ChatRepo>(() => ChatRepoImpl(sl()))

        //state management
        ..registerLazySingleton<SplashBloc>(() => SplashBloc(sl()))
        ..registerFactory<AuthCubit>(() => AuthCubit(sl(), sl(), sl()))
        ..registerFactory<ProfileBloc>(
            () => ProfileBloc(sl(), sl(), sl(), sl()))
        ..registerFactory<TaskCubit>(() => TaskCubit(sl(), sl(), sl(), sl(),
            sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()))
        ..registerFactory<ChatBloc>(() => ChatBloc(
              sl(),
              sl(),
              sl(),
              sl(),
              sl(),
        ))
      // ..registerFactory<C>(() => null)
      ;
}
