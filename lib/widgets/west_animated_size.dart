import 'package:flutter/material.dart';
import 'package:west/theme/animation_theme.dart';

class WestAnimatedSize extends StatelessWidget {
  const WestAnimatedSize({
    super.key,
    required this.child,
    this.curve = Curves.easeOutCubic,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final Curve curve;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSize(
      duration: theme.animation.fast,
      alignment: alignment,
      curve: curve,
      child: child,
    );
  }
}
