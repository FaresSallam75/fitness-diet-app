import 'package:flutter/material.dart';

class BaseRoute extends PageRouteBuilder {
  BaseRoute({required super.pageBuilder, RouteSettings? settings})
    : super(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (_, animation, secondaryAnimation, widget) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: widget,
          );
        },
      );
}
