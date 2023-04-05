import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:west/theme/animation_theme.dart';

import 'fade_page_route.dart';
import 'slide_page_route.dart';

/// Determines the transition of the [WestPage].
enum PageRouteType { platform, slide, fade }

class WestPage<T> extends Page<T> {
  const WestPage({
    required this.builder,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.pageRouteType = PageRouteType.slide,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final WidgetBuilder builder;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  /// Determines which page route is used.
  final PageRouteType pageRouteType;

  @override
  Route<T> createRoute(BuildContext context) {
    final theme = Theme.of(context);

    switch (pageRouteType) {
      case PageRouteType.platform:
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.iOS:
            continue slide;
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            continue fade;
        }
      slide:
      case PageRouteType.slide:
        return SlidePageRoute(
          settings: this,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        );
      fade:
      case PageRouteType.fade:
        return FadePageRoute(
          settings: this,
          duration: theme.animation.fast,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          builder: builder,
        );
    }
  }
}
