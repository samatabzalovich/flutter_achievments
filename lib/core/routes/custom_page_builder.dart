import 'package:flutter/material.dart';

class MyCustomRouteFadeTransition<T> extends PageRouteBuilder<T> {
  final Widget route;
  MyCustomRouteFadeTransition({required this.route, required String name})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          settings: RouteSettings(name: name),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            return FadeTransition(
              opacity: tween,
              child: child,
            );
          },
        );
}

class MyCustomRouteNoAnimationTransition<T> extends PageRouteBuilder<T> {
  final Widget route;
  

  MyCustomRouteNoAnimationTransition(
      {required this.route, required String name})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          settings: RouteSettings(name: name),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var end = Offset.zero; // Full screen (top-left corner)
            var curve = Curves.ease;

            // expand animation

            

            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        );
}

class MyCustomRouteSlideTransition<T> extends PageRouteBuilder<T> {
  final Widget route;
  MyCustomRouteSlideTransition({required this.route, required String name})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          settings: RouteSettings(name: name),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.decelerate),
            );
            return SlideTransition(
              position: tween,
              child: child,
            );
          },
        );
}
