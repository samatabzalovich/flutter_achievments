
part of 'get_it.dart';
final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase
  sl
        // dependencies
        ..registerLazySingleton(() => FirebaseAuth.instance)
        ..registerLazySingleton(() => FirebaseFirestore.instance)

        //state management
        ..registerSingleton(SplashBloc(sl()))

        // data sources
        ..registerLazySingleton<SplashDataSource>(() => SplashDataSourceImpl(sl(), sl()))

        // repositories
        ..registerLazySingleton<SplashRepo>(() => SplashRepoImpl(sl()))

        // usecases
        ..registerLazySingleton<AuthStateUseCase>(() => AuthStateUseCase(sl()))
      ;
  
}