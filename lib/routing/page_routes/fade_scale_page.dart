import 'package:flutter/widgets.dart';

import 'page_routes.dart';

class FadeScalePage extends Page {
  const FadeScalePage({
    LocalKey? key,
    String? name,
    required this.child,
  }) : super(key: key, name: name);

  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRoutes.fadeScale(
      () => child,
      this,
    );
  }
}
