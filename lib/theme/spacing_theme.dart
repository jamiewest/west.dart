import 'dart:ui';

import 'package:flutter/material.dart';

/// Contains spacing values that are used throughout the library.
class WestSpacingTheme extends ThemeExtension<WestSpacingTheme> {
  const WestSpacingTheme({
    required this.base,
    double? small,
    double? large,
  })  : small = small ?? base / 2,
        large = large ?? base * 2;

  final double small;
  final double base;
  final double large;

  // final double xxs;
  // final double xs;
  // final double sm;
  // final double md;
  // final double lg;
  // final double xl;
  // final double xxl;
  // final double offset;

  EdgeInsetsDirectional get smallEdgeInsets => EdgeInsetsDirectional.all(small);
  EdgeInsetsDirectional get edgeInsets => EdgeInsetsDirectional.all(base);
  EdgeInsetsDirectional get largeEdgeInsets => EdgeInsetsDirectional.all(large);

  EdgeInsetsDirectional only({
    bool start = false,
    bool end = false,
    bool top = false,
    bool bottom = false,
  }) {
    return EdgeInsetsDirectional.only(
      start: start ? base : 0,
      end: end ? base : 0,
      top: top ? base : 0,
      bottom: bottom ? base : 0,
    );
  }

  EdgeInsetsDirectional symmetric({
    bool horizontal = false,
    bool vertical = false,
  }) {
    return EdgeInsetsDirectional.only(
      start: horizontal ? base : 0,
      end: horizontal ? base : 0,
      top: vertical ? base : 0,
      bottom: vertical ? base : 0,
    );
  }

  @override
  WestSpacingTheme copyWith({
    double? small,
    double? base,
    double? large,
  }) {
    return WestSpacingTheme(
      small: small ?? this.small,
      base: base ?? this.base,
      large: large ?? this.large,
    );
  }

  @override
  ThemeExtension<WestSpacingTheme> lerp(
    ThemeExtension<WestSpacingTheme>? other,
    double t,
  ) {
    if (other is! WestSpacingTheme) return this;

    return WestSpacingTheme(
      small: lerpDouble(small, other.small, t),
      base: lerpDouble(base, other.base, t) ?? base,
      large: lerpDouble(large, other.large, t),
    );
  }
}

extension WestSpacingThemeExtension on ThemeData {
  WestSpacingTheme get spacing => extension<WestSpacingTheme>()!;
}
