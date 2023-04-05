import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:west/misc/size_provider.dart';
import 'package:west/west.dart';

import 'animation_theme.dart';
import 'icon_data_theme.dart';
import 'shape_theme.dart';
import 'spacing_theme.dart';

typedef WestThemeBuilder = WestTheme Function(double scale);

final scaleProvider = StateProvider<double>((ref) {
  final screenSize = ref.watch(sizeProvider);

  double newScale;
  final shortestSide = screenSize.shortestSide;

  newScale = 1;
  if (shortestSide > 1201) {
    newScale = 1.15;
  } else if (shortestSide > 768) {
    newScale = 1.05;
  } else if (shortestSide > 0) {
    newScale = 1;
  }

  return newScale;
});

final themeProvider = Provider.family<ThemeData, WestThemeBuilder>(
  (ref, builder) {
    final scale = ref.watch(scaleProvider);
    return builder(scale).data;
  },
);

class WestTheme {
  WestTheme({
    required this.scale,
    required ColorScheme colorScheme,
    WestShapeTheme? shape,
    WestSpacingTheme? spacing,
    WestAnimationTheme? animation,
    WestIconDataTheme? iconData,
  }) {
    spacing = spacing ?? const WestSpacingTheme(base: 16);
    shape = shape ?? WestShapeTheme(radius: const Radius.circular(16));
    animation = animation ??
        WestAnimationTheme(
          fast: 300.ms,
          medium: 600.ms,
          slow: 900.ms,
          pageTransition: 200.ms,
        );
    iconData = iconData ??
        WestIconDataTheme(
          drawer: (_) => const RotatedBox(
            quarterTurns: 1,
            child: Icon(CupertinoIcons.chart_bar_alt_fill),
          ),
          close: (_) => const Icon(CupertinoIcons.xmark),
          back: (_) => Transform.translate(
            offset: const Offset(-1, 0),
            child: const Icon(CupertinoIcons.left_chevron),
          ),
          expand: (_) => const Icon(CupertinoIcons.chevron_down),
        );

    final textTheme = colorScheme.brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    data = ThemeData.from(colorScheme: colorScheme).copyWith(
      textTheme: textTheme
          .copyWith(
            displayLarge: _createStyle(
              sizePx: 57,
              heightPx: 64,
              weight: FontWeight.w400,
              spacingPc: -0.25,
            ),
            displayMedium: _createStyle(
              sizePx: 45,
              heightPx: 52,
              weight: FontWeight.w400,
            ),
            displaySmall: _createStyle(
              sizePx: 36,
              heightPx: 44,
              weight: FontWeight.w400,
            ),
            headlineLarge: _createStyle(
              sizePx: 32,
              heightPx: 40,
              weight: FontWeight.w400,
            ),
            headlineMedium: _createStyle(
              sizePx: 28,
              heightPx: 36,
              weight: FontWeight.w400,
            ),
            headlineSmall: _createStyle(
              sizePx: 24,
              heightPx: 32,
              weight: FontWeight.w400,
            ),
            titleLarge: _createStyle(
              sizePx: 22,
              heightPx: 28,
              weight: FontWeight.w400,
            ),
            titleMedium: _createStyle(
              sizePx: 16,
              heightPx: 24,
              weight: FontWeight.w500,
              spacingPc: .15,
            ),
            titleSmall: _createStyle(
              sizePx: 14,
              heightPx: 20,
              weight: FontWeight.w500,
              spacingPc: .1,
            ),
            labelLarge: _createStyle(
              sizePx: 14,
              heightPx: 20,
              weight: FontWeight.w500,
              spacingPc: .1,
            ),
            labelMedium: _createStyle(
              sizePx: 12,
              heightPx: 16,
              weight: FontWeight.w500,
              spacingPc: .5,
            ),
            labelSmall: _createStyle(
              sizePx: 11,
              heightPx: 16,
              weight: FontWeight.w500,
              spacingPc: .5,
            ),
            bodyLarge: _createStyle(
              sizePx: 16,
              heightPx: 24,
              weight: FontWeight.w400,
              spacingPc: .5,
            ),
            bodyMedium: _createStyle(
              sizePx: 14,
              heightPx: 20,
              weight: FontWeight.w400,
              spacingPc: .25,
            ),
            bodySmall: _createStyle(
              sizePx: 12,
              heightPx: 16,
              weight: FontWeight.w400,
              spacingPc: .4,
            ),
          )
          .apply(fontSizeFactor: scale, bodyColor: textTheme.labelLarge?.color),

      //
      useMaterial3: true,

      // prevent platform depended padding values in material widgets
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,

      //
      splashColor: colorScheme.secondary.withOpacity(.1),
      highlightColor: colorScheme.secondary.withOpacity(.1),

      //
      iconTheme: IconThemeData(
        color: colorScheme.onBackground,
        size: 20,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: shape.shape,
        color: colorScheme.surfaceVariant,
        margin: EdgeInsets.zero,
      ),
      dialogTheme: DialogTheme(shape: shape.shape),
      snackBarTheme: SnackBarThemeData(
        elevation: 0,
        shape: shape.shape,
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.surfaceVariant,
        actionTextColor: colorScheme.primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? colorScheme.primary
              : null,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(
          (state) => state.contains(MaterialState.selected)
              ? colorScheme.primary
              : null,
        ),
        trackColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? colorScheme.primary.withAlpha(0x80)
              : null,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: shape.shape,
        enableFeedback: true,
        elevation: 0,
        color: colorScheme.surfaceVariant,
        textStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(spacing.base),
        border: OutlineInputBorder(borderRadius: shape.borderRadius),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        thumbColor: colorScheme.primary,
        valueIndicatorColor: colorScheme.primary.withOpacity(.8),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorTextStyle: textTheme.titleMedium?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.base,
          vertical: spacing.small,
        ),
        textStyle: textTheme.titleSmall?.copyWith(color: colorScheme.onPrimary),
        preferBelow: false,
        decoration: BoxDecoration(
          borderRadius: shape.borderRadius,
          color: colorScheme.primary.withOpacity(.8),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(radius: shape.radius),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        color: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
      ),

      // buttons
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: spacing.base,
              vertical: spacing.small,
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: shape.borderRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: spacing.base,
              vertical: spacing.small,
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size.zero),
          side: MaterialStateProperty.all(
            BorderSide(color: colorScheme.primary.withOpacity(.8)),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: shape.borderRadius,
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: spacing.base,
              vertical: spacing.small,
            ),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(Size.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: shape.borderRadius),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? colorScheme.primary.withOpacity(.12)
                : colorScheme.primary,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? colorScheme.onBackground.withOpacity(.38)
                : colorScheme.onPrimary,
          ),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return colorScheme.onPrimary.withOpacity(0.08);
            } else if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return colorScheme.onPrimary.withOpacity(0.24);
            } else {
              return null;
            }
          }),
        ),
      ),

      //
      extensions: [
        spacing,
        shape,
        animation,
        iconData,
      ],
    );
  }

  final double scale;

  late final ThemeData data;

  TextStyle _createStyle({
    required double sizePx,
    required double heightPx,
    double spacingPc = 1,
    FontWeight? weight,
  }) {
    sizePx *= scale;
    heightPx *= scale;

    return TextStyle(
      fontSize: sizePx,
      height: heightPx / sizePx,
      letterSpacing: sizePx * spacingPc * 0.01,
      fontWeight: weight,
    );
  }

  TextStyle _createFont(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    sizePx *= scale;
    if (heightPx != null) {
      heightPx *= scale;
    }
    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing:
          spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }
}
