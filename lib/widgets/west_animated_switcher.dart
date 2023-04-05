import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:west/theme/animation_theme.dart';

/// Builds an [AnimatedSwitcher] with some predefined defaults.
class WestAnimatedSwitcher extends StatelessWidget {
  const WestAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration,
    this.reverseDuration,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
  });

  const WestAnimatedSwitcher.sliver({
    super.key,
    required this.child,
    this.duration,
    this.reverseDuration,
  })  : transitionBuilder = SliverAnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder = SliverAnimatedSwitcher.defaultLayoutBuilder;

  final Widget child;

  /// Defaults to [WestAnimationTheme.fast].
  final Duration? duration;

  final Duration? reverseDuration;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final AnimatedSwitcherLayoutBuilder layoutBuilder;

  @override
  Widget build(BuildContext context) {
    final duration = this.duration ?? Theme.of(context).animation.fast;

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: transitionBuilder,
      layoutBuilder: layoutBuilder,
      child: child,
    );
  }
}
