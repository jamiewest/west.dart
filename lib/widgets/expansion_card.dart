import 'package:flutter/material.dart';
import 'package:west/theme/animation_theme.dart';
import 'package:west/theme/icon_data_theme.dart';
import 'package:west/theme/spacing_theme.dart';

import 'west_button.dart';

/// A card which can collapse to hide its children.
///
/// Similar to the material [ExpansionPanel].
class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    super.key,
    required this.title,
    required this.children,
    this.initiallyCollapsed = false,
  });

  final Widget title;
  final List<Widget> children;
  final bool initiallyCollapsed;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  late bool _collapsed = widget.initiallyCollapsed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => setState(() => _collapsed = !_collapsed),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: theme.spacing.edgeInsets,
                    child: DefaultTextStyle(
                      style: theme.textTheme.titleSmall!,
                      child: widget.title,
                    ),
                  ),
                ),
                WestButton.transparent(
                  padding: EdgeInsets.symmetric(
                    vertical: theme.spacing.base,
                    horizontal: theme.spacing.base * 1.5,
                  ),
                  icon: AnimatedRotation(
                    duration: theme.animation.fast,
                    curve: Curves.easeOut,
                    turns: _collapsed ? .5 : 0,
                    child: theme.iconData.expand(context),
                  ),
                  onTap: () => setState(() => _collapsed = !_collapsed),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: theme.animation.fast,
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeOut,
            sizeCurve: Curves.easeOutCubic,
            crossFadeState: _collapsed
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: AnimatedScale(
              duration: theme.animation.fast,
              scale: _collapsed ? .95 : 1,
              curve: Curves.easeInOut,
              child: Column(children: widget.children),
            ),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
