
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
        //data sources
        .. registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSourceImpl(sl(), sl()))
        ..registerLazySingleton<SplashDataSource>(() => SplashDataSourceImpl(sl(), sl()))
        ..registerLazySingleton<ProfileRemoteSource>(() => ProfileRemoteSourceImpl(sl(), sl(), sl()))

        // usecases
        ..registerLazySingleton<AuthStateUseCase>(() => AuthStateUseCase(sl()))
        ..registerLazySingleton(() => RegisterUseCase( sl()))
        ..registerLazySingleton(() => SignInUseCase(sl()))
        ..registerLazySingleton(() => UpdateAvatarUseCase(sl()))
        ..registerLazySingleton(() => UpdateProfileUseCase(sl()))
        ..registerLazySingleton(() => CreateChildProfileUseCase(sl()))
        ..registerLazySingleton(() => CreateChildUseCase(sl()))
        ..registerLazySingleton(() => SignOutUseCase(sl()))

        // repositories
        ..registerLazySingleton<SplashRepo>(() => SplashRepoImpl(sl()))
        ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
        ..registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(sl()))
        
        //state management
        ..registerLazySingleton<SplashBloc>(() => SplashBloc(sl()))
        ..registerFactory<AuthCubit>(() => AuthCubit(sl(), sl(), sl()))
        ..registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl(), sl(), sl()))
      ;
  
}