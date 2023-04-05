import 'package:flutter/material.dart';
import 'package:west/theme/spacing_theme.dart';
import 'package:west/widgets/spacer.dart';

abstract class WestButton extends StatelessWidget {
  const WestButton();

  /// A [TextButton] based on the [ThemeData.textButtonTheme].
  const factory WestButton.text({
    required VoidCallback? onTap,
    Widget? icon,
    Widget? label,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
  }) = _WestTextButton;

  /// An [ElevatedButton] based on the [ThemeData.elevatedButtonTheme].
  const factory WestButton.elevated({
    required VoidCallback? onTap,
    Widget? icon,
    Widget? label,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
  }) = _WestElevatedButton;

  /// An [ElevatedButton] based on the [ThemeData.outlinedButtonTheme].
  const factory WestButton.outlined({
    required VoidCallback? onTap,
    Widget? icon,
    Widget? label,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
  }) = _WestOutlinedButton;

  /// A flat transparent button with even vertical and horizontal padding.
  const factory WestButton.transparent({
    required VoidCallback? onTap,
    Widget? icon,
    Widget? label,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
  }) = _WestTransparentButton;

  /// A flat button that matches the style of a [Card] with even vertical and
  /// horizontal padding.
  const factory WestButton.card({
    required VoidCallback? onTap,
    Widget? icon,
    Widget? label,
    VoidCallback? onLongPress,
    EdgeInsetsGeometry? padding,
    Color? foregroundColor,
    Color? backgroundColor,
  }) = _WestCardButton;
}

class _WestTextButton extends WestButton {
  const _WestTextButton({
    required this.onTap,
    this.icon,
    this.label,
    this.onLongPress,
    this.padding,
  });

  final Widget? icon;
  final Widget? label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      style: theme.textButtonTheme.style?.copyWith(
        padding: MaterialStateProperty.all(padding),
      ),
      onPressed: onTap,
      onLongPress: onLongPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) HorizontalSpacer.small,
          if (label != null) label!,
        ],
      ),
    );
  }
}

class _WestElevatedButton extends WestButton {
  const _WestElevatedButton({
    required this.onTap,
    this.icon,
    this.label,
    this.onLongPress,
    this.padding,
  });

  final Widget? icon;
  final Widget? label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: theme.textButtonTheme.style?.copyWith(
        padding: MaterialStateProperty.all(padding),
      ),
      onPressed: onTap,
      onLongPress: onLongPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) HorizontalSpacer.small,
          if (label != null) label!,
        ],
      ),
    );
  }
}

class _WestOutlinedButton extends WestButton {
  const _WestOutlinedButton({
    required this.onTap,
    this.icon,
    this.label,
    this.onLongPress,
    this.padding,
  });

  final Widget? icon;
  final Widget? label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      style: theme.textButtonTheme.style?.copyWith(
        padding: MaterialStateProperty.all(padding),
      ),
      onPressed: onTap,
      onLongPress: onLongPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) HorizontalSpacer.small,
          if (label != null) label!,
        ],
      ),
    );
  }
}

class _WestTransparentButton extends WestButton {
  const _WestTransparentButton({
    required this.onTap,
    this.icon,
    this.label,
    this.onLongPress,
    this.padding,
  });

  final Widget? icon;
  final Widget? label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? theme.colorScheme.onBackground.withOpacity(.5)
            : theme.colorScheme.onBackground,
      ),
      overlayColor: MaterialStateProperty.all(theme.highlightColor),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        padding ?? theme.spacing.edgeInsets,
      ),
    );

    return TextButton(
      onPressed: onTap,
      onLongPress: onLongPress,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) HorizontalSpacer.small,
          if (label != null) label!,
        ],
      ),
    );
  }
}

class _WestCardButton extends WestButton {
  const _WestCardButton({
    required this.onTap,
    this.icon,
    this.label,
    this.onLongPress,
    this.padding,
    this.foregroundColor,
    this.backgroundColor,
  });

  final Widget? icon;
  final Widget? label;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final background = backgroundColor ?? theme.cardTheme.color!;
    final foreground = foregroundColor ?? theme.colorScheme.onBackground;

    final style = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? background.withOpacity(0)
            : background,
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? foreground.withOpacity(.5)
            : foreground,
      ),
      overlayColor: MaterialStateProperty.all(theme.highlightColor),
      elevation: MaterialStateProperty.all(theme.cardTheme.elevation),
      padding: MaterialStateProperty.all(
        padding ?? theme.spacing.edgeInsets,
      ),
    );

    return ElevatedButton(
      onPressed: onTap,
      onLongPress: onLongPress,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) HorizontalSpacer.small,
          if (label != null) label!,
        ],
      ),
    );
  }
}
