part of 'router.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MyCustomRouteFadeTransition(
          name: '/', route: const SplashScreen());

    // Sign Up and Profile Routes
    case TermsOfUsePage.routeName:
      return MyCustomRouteSlideTransition(
          name: TermsOfUsePage.routeName, route: const TermsOfUsePage());
    case ChooseTypePage.routeName:
      return MyCustomRouteSlideTransition(
          name: ChooseTypePage.routeName, route: const ChooseTypePage());
    case SignUpPage.routeName:
      final args = settings.arguments as UserType;
      return MyCustomRouteSlideTransition(
        name: SignUpPage.routeName,
        route: BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: SignUpPage(args),
        ),
      );
    case LoginPage.routeName:
      return MyCustomRouteSlideTransition(
          name: LoginPage.routeName,
          route: BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const LoginPage(),
          ));
    case AccountPrefPage.routeName:
      return MyCustomRouteFadeTransition(
          name: AccountPrefPage.routeName,
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
        name: AvatarPage.routeName,
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
        name: ChildProfilePage.routeName,
        route: const ChildProfilePage(),
      );
    case SignUpChildPage.routeName:
      final args = settings.arguments as ChildEntity;
      return MyCustomRouteFadeTransition(
        name: SignUpChildPage.routeName,
        route: SignUpChildPage(
          childProfile: args,
        ),
      );

    // Home Routes
    case ParentHomePage.routeName:
      return MyCustomRouteFadeTransition(
        name: ParentHomePage.routeName,
        route: ChangeNotifierProvider(
            create: (_) => PageIndexProvider(),
            child: BlocProvider(
              create: (context) {
                final id = Provider.of<UserProvider>(context, listen: false)
                    .currentUser!
                    .id;
                return sl<TaskCubit>()
                  ..getTasks(selectedDate: DateTime.now(), userId: id, context: context);
              },
              child: const ParentHomePage(),
            )),
      );
    case ChildHomePage.routeName:
      return MyCustomRouteFadeTransition(
        name: ChildHomePage.routeName,
        route: const ChildHomePage(),
      );
    //create task pages
    case ChooseCategoryTaskPage.routeName:
      return MyCustomRouteFadeTransition(
          name: ChooseCategoryTaskPage.routeName,
          route: const ChooseCategoryTaskPage());
    case CreateTaskPage.routeName:
      final args = settings.arguments as TaskType;
      return MyCustomRouteSlideTransition(
          name: CreateTaskPage.routeName,
          route: BlocProvider(
            create: (context) => sl<TaskCubit>(),
            child: CreateTaskPage(
              selectedType: args,
            ),
          ));

    // details page
    case TaskPage.routeName:
      final args = settings.arguments as TaskEntity;
      return MyCustomRouteFadeTransition(
          name: TaskPage.routeName,
          route: TaskPage(
            task: args,
          ));

    case ChatPage.routeName:
      final args = settings.arguments as TaskEntity;
      return MyCustomRouteNoAnimationTransition(
          name: ChatPage.routeName,
          route: ChatPage(
            task: args,
          ));
    default:
      return MyCustomRouteFadeTransition(
          name: '/not-found', route: const RouteNotFoundPage());
  }
}
