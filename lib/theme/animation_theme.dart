import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WestAnimationTheme extends ThemeExtension<WestAnimationTheme> {
  const WestAnimationTheme({
    required this.fast,
    required this.medium,
    required this.slow,
    required this.pageTransition,
  });

  final Duration fast;
  final Duration medium;
  final Duration slow;
  final Duration pageTransition;

  @override
  ThemeExtension<WestAnimationTheme> copyWith({
    Duration? fast,
    Duration? medium,
    Duration? slow,
    Duration? pageTransition,
  }) {
    return WestAnimationTheme(
      fast: fast ?? this.fast,
      medium: medium ?? this.medium,
      slow: slow ?? this.slow,
      pageTransition: pageTransition ?? this.pageTransition,
    );
  }

  @override
  ThemeExtension<WestAnimationTheme> lerp(
    ThemeExtension<WestAnimationTheme>? other,
    double t,
  ) {
    if (other is! WestAnimationTheme) return this;

    return WestAnimationTheme(
      fast: lerpDuration(fast, other.fast, t),
      medium: lerpDuration(medium, other.medium, t),
      slow: lerpDuration(slow, other.slow, t),
      pageTransition: lerpDuration(pageTransition, other.pageTransition, t),
    );
  }
}

extension WestAnimationThemeExtension on ThemeData {
  WestAnimationTheme get animation => extension<WestAnimationTheme>()!;
}
