import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:west/theme/spacing_theme.dart';

import 'west_dialog.dart';
import 'west_list_tile.dart';
import 'west_radio_tile.dart';

class WestRadioDialogTile<T> extends StatelessWidget {
  const WestRadioDialogTile({
    super.key,
    required this.groupValue,
    required this.entries,
    required this.onChanged,
    this.leading,
    this.title,
    this.borderRadius,
    this.dialogTitle,
  });

  final T groupValue;
  final Map<T, Widget> entries;

  final Widget? leading;
  final Widget? title;
  final BorderRadius? borderRadius;

  final Widget? dialogTitle;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WestListTile(
      leading: leading,
      title: title,
      subtitle: entries[groupValue],
      multilineTitle: true,
      borderRadius: borderRadius,
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => WestDialog(
          title: dialogTitle,
          contentPadding: theme.spacing.only(top: true),
          clipBehavior: Clip.antiAlias,
          content: Column(
            children: [
              for (final entry in entries.entries)
                WestRadioTile<T>(
                  title: entry.value,
                  value: entry.key,
                  groupValue: groupValue,
                  onChanged: (value) {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                    if (value != groupValue) onChanged?.call(value);
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
