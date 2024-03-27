part of 'router.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MyCustomRouteFadeTransition(route: const SplashScreen());

    // Sign Up and Profile Routes
    case TermsOfUsePage.routeName:
      return MyCustomRouteSlideTransition(route: const TermsOfUsePage());
    case ChooseTypePage.routeName:
      return MyCustomRouteSlideTransition(route: const ChooseTypePage());
    case SignUpPage.routeName:
      final args = settings.arguments as UserType;
      return MyCustomRouteSlideTransition(
        route: BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: SignUpPage(args),
        ),
      );
    case LoginPage.routeName:
      return MyCustomRouteSlideTransition(
          route: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const LoginPage(),
      ));
    case AccountPrefPage.routeName:
      return MyCustomRouteFadeTransition(
          route: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: const AccountPrefPage(),
      ));

    case AvatarPage.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final user = args['user'] as UserEntity;
      final navBarTitle = args['navBarTitle'] as String;
      final userCredentials = args['userCredentials'] as Map<String, String>?;
      return MyCustomRouteSlideTransition(
        route: BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: AvatarPage(
            pageName: navBarTitle,
            user: user,
            userCredentials: userCredentials,
          ),
        ),
      );
    case ChildProfilePage.routeName:
      return MyCustomRouteSlideTransition(
        route: const ChildProfilePage(),
      );
    case SignUpChildPage.routeName:
      final args = settings.arguments as ChildEntity;
      return MyCustomRouteFadeTransition(
        route: SignUpChildPage(
          childProfile: args,
        ),
      );
    
    // Home Routes
    case ParentHomePage.routeName:
      return MyCustomRouteFadeTransition(
        route: ChangeNotifierProvider(
          create: (_) => PageIndexProvider(),
          child: const ParentHomePage()),
      );
    case ChildHomePage.routeName:
      return MyCustomRouteFadeTransition(
        route: const ChildHomePage(),
      );
      //create task pages
    case ChooseCategoryTaskPage.routeName:
      return MyCustomRouteFadeTransition(route: const ChooseCategoryTaskPage());
case CreateTaskPage.routeName:
final args = settings.arguments as TaskType;
      return MyCustomRouteSlideTransition(route:  CreateTaskPage(
        selectedType: args,
      ));
    default:
      return MyCustomRouteFadeTransition(route: const RouteNotFoundPage());
  }
}
