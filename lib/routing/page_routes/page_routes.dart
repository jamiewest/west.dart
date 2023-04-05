import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

typedef PageBuilder = Widget Function();

class PageRoutes {
  static const double kDefaultDuration = .3;

  static Route<T> fadeThrough<T>(PageBuilder page,
      [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }

  static Route<T> fadeScale<T>(PageBuilder page, RouteSettings settings,
      {bool fullScreenDialog = false, double duration = kDefaultDuration}) {
    return PageRouteBuilder<T>(
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
    );
  }

  static Route<T> sharedAxis<T>(PageBuilder page, RouteSettings settings,
      {bool fullScreenDialog = false,
      SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
      double duration = kDefaultDuration}) {
    return PageRouteBuilder<T>(
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          child: child,
        );
      },
    );
  }
}
