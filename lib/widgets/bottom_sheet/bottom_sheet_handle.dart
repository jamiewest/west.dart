import 'package:flutter/material.dart';
import 'package:west/theme/shape_theme.dart';
import 'package:west/theme/spacing_theme.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 50,
      height: 4,
      margin: EdgeInsets.symmetric(vertical: theme.spacing.small),
      decoration: BoxDecoration(
        borderRadius: theme.shape.borderRadius,
        color: theme.colorScheme.onBackground.withOpacity(.2),
      ),
    );
  }
}
