part of 'router.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MyCustomRouteFadeTransition(route: const SplashScreen());
    case TermsOfUsePage.routeName:
      return MyCustomRouteFadeTransition(route: const TermsOfUsePage());
    default:
      return MyCustomRouteFadeTransition(route: const RouteNotFoundPage());
  }
}
