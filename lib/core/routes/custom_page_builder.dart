import 'package:flutter/material.dart';

class MyCustomRouteFadeTransition<T> extends PageRouteBuilder<T> {
  final Widget route;
  MyCustomRouteFadeTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
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
