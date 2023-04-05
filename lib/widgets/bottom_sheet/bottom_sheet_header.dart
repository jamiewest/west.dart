import 'package:flutter/material.dart';
import 'package:west/theme/spacing_theme.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: theme.spacing.edgeInsets,
      child: DefaultTextStyle(
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.primary,
        ),
        textAlign: TextAlign.center,
        child: child,
      ),
    );
  }
}
