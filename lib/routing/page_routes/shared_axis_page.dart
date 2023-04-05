import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

import 'page_routes.dart';

class SharedAxisPage extends Page {
  const SharedAxisPage({
    LocalKey? key,
    String? name,
    required this.child,
  }) : super(key: key, name: name);

  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRoutes.sharedAxis(
      () => child,
      this,
      type: SharedAxisTransitionType.horizontal,
    );
  }
}
