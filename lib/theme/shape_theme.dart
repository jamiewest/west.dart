import 'package:flutter/material.dart';

class WestShapeTheme extends ThemeExtension<WestShapeTheme> {
  WestShapeTheme({
    required this.radius,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  })  : borderRadius = borderRadius ?? BorderRadius.all(radius),
        shape = shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(radius),
            );

  final Radius radius;
  final BorderRadius borderRadius;
  final ShapeBorder shape;

  @override
  WestShapeTheme copyWith({
    Radius? radius,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
  }) {
    return WestShapeTheme(
      radius: radius ?? this.radius,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }

  @override
  ThemeExtension<WestShapeTheme> lerp(
    ThemeExtension<WestShapeTheme>? other,
    double t,
  ) {
    if (other is! WestShapeTheme) return this;

    return WestShapeTheme(
      radius: Radius.lerp(radius, other.radius, t) ?? radius,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
    );
  }
}

extension WestShapeThemeExtension on ThemeData {
  WestShapeTheme get shape => extension<WestShapeTheme>()!;
}
