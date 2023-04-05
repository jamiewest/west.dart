import 'package:flutter/material.dart';

class WestIconDataTheme extends ThemeExtension<WestIconDataTheme> {
  WestIconDataTheme({
    required this.drawer,
    required this.close,
    required this.back,
    required this.expand,
  });

  final WidgetBuilder drawer;
  final WidgetBuilder close;
  final WidgetBuilder back;
  final WidgetBuilder expand;

  @override
  ThemeExtension<WestIconDataTheme> copyWith({
    WidgetBuilder? drawer,
    WidgetBuilder? close,
    WidgetBuilder? back,
    WidgetBuilder? expand,
  }) {
    return WestIconDataTheme(
      drawer: drawer ?? this.close,
      close: close ?? this.close,
      back: back ?? this.back,
      expand: expand ?? this.expand,
    );
  }

  @override
  ThemeExtension<WestIconDataTheme> lerp(
    ThemeExtension<WestIconDataTheme>? other,
    double t,
  ) {
    return other ?? this;
  }
}

extension WestIconDataThemeExtension on ThemeData {
  WestIconDataTheme get iconData => extension<WestIconDataTheme>()!;
}
