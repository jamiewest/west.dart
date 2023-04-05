import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../west_button.dart';
import '../west_list_tile.dart';
import 'west_popup_menu.dart';

/// A custom popup menu button that calls [showWestMenu] to show a menu.
class WestPopupMenuButton<T> extends StatefulWidget {
  const WestPopupMenuButton({
    super.key,
    required this.itemBuilder,
    this.onSelected,
    this.onCancelled,
    this.enabled = true,
  });

  final PopupMenuItemBuilder<T> itemBuilder;
  final PopupMenuItemSelected<T>? onSelected;
  final VoidCallback? onCancelled;
  final bool enabled;

  @override
  State<WestPopupMenuButton<T>> createState() => _WestPopupMenuButtonState<T>();
}

class _WestPopupMenuButtonState<T> extends State<WestPopupMenuButton<T>> {
  void _showButtonMenu() {
    final button = context.findRenderObject()! as RenderBox;
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final items = widget.itemBuilder(context);

    if (items.isNotEmpty) {
      showWestMenu(
        context: context,
        items: items,
        position: position,
      ).then((newValue) {
        if (!mounted) return;

        if (newValue == null) {
          widget.onCancelled?.call();
        } else {
          HapticFeedback.lightImpact();
          widget.onSelected?.call(newValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WestButton.transparent(
      icon: const Icon(CupertinoIcons.ellipsis_vertical),
      onTap: widget.enabled ? _showButtonMenu : null,
    );
  }
}

class WestPopupMenuListTile<T> extends PopupMenuEntry<T> {
  const WestPopupMenuListTile({
    super.key,
    required this.value,
    this.leading,
    this.title,
    this.trailing,
    this.enabled = true,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  /// The value that will be returned by [showMenu] if this entry is selected.
  ///
  /// When `null`, [WestPopupMenuButton.onCancelled] will be called if this
  /// item is selected.
  final T? value;

  /// Whether the user is permitted to select this item.
  final bool enabled;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => value == this.value;

  @override
  State<WestPopupMenuListTile<T>> createState() =>
      _WestPopupMenuListTileState<T, WestPopupMenuListTile<T>>();
}

class _WestPopupMenuListTileState<T, W extends WestPopupMenuListTile<T>>
    extends State<W> {
  @override
  Widget build(BuildContext context) {
    return WestListTile(
      leading: widget.leading,
      title: widget.title,
      trailing: widget.trailing,
      borderRadius: BorderRadius.zero,
      onTap:
          widget.enabled ? () => Navigator.of(context).pop(widget.value) : null,
    );
  }
}

class WestPopupMenuRow<T> extends PopupMenuEntry<T> {
  const WestPopupMenuRow({
    super.key,
    required this.children,
  }) : assert(children.length <= 4);

  final List<WestPopupMenuIcon<T>> children;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => false;

  @override
  State<WestPopupMenuRow<T>> createState() =>
      _WestPopupMenuRow<T, WestPopupMenuRow<T>>();
}

class _WestPopupMenuRow<T, W extends WestPopupMenuRow<T>> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.children,
    );
  }
}

class WestPopupMenuIcon<T> extends PopupMenuEntry<T> {
  const WestPopupMenuIcon({
    super.key,
    required this.value,
    required this.icon,
    this.enabled = true,
  });

  final Widget icon;

  /// The value that will be returned by [showMenu] if this entry is selected.
  ///
  /// When `null`, [WestPopupMenuButton.onCancelled] will be called if this
  /// item is selected.
  final T? value;

  final bool enabled;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => value == this.value;

  @override
  State<WestPopupMenuIcon<T>> createState() =>
      _WestPopupMenuIcon<T, WestPopupMenuIcon<T>>();
}

class _WestPopupMenuIcon<T, W extends WestPopupMenuIcon<T>> extends State<W> {
  @override
  Widget build(BuildContext context) {
    return WestButton.transparent(
      icon: widget.icon,
      onTap:
          widget.enabled ? () => Navigator.of(context).pop(widget.value) : null,
    );
  }
}
