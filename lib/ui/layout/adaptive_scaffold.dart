import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'adaptive_layout.dart';
import 'breakpoints.dart';
import 'slot_layout.dart';

class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({
    super.key,
    required this.body,
    required this.destinations,
    this.controller,
    this.smallBreakpoint = Breakpoints.small,
    this.mediumBreakpoint = Breakpoints.medium,
    this.largeBreakpoint = Breakpoints.large,
    this.drawerBreakpoint = Breakpoints.smallDesktop,
    this.appBar,
    this.useDrawer = true,
    this.bottomNavigationOverflow = 5,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.fabInRail = true,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationInAnimation,
    this.bottomNavigationOutAnimation,
    this.navigationRailInAnimation,
    this.navigationRailOutAnimation,
    this.drawerInAnimation,
    this.drawerOutAnimation,
    this.persistentFooterButtons,
    this.endDrawer,
    this.drawerScrimColor,
    this.backgroundColor,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = true,
    this.extendBodyBehindAppBar = false,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.drawerHeader,
    this.navigationRailTrailing,
    this.smallBody,
    this.largeBody,
    this.smallSecondaryBody,
    this.secondaryBody,
    this.largeSecondaryBody,
  });

  /// Widget to be displayed in the body slot at the smallest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallBody;

  /// Widget to be displayed in the body slot at the middle breakpoint.
  ///
  /// The default displayed body.
  final WidgetBuilder? body;

  /// Widget to be displayed in the body slot at the largest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeBody;

  /// Widget to be displayed in the secondaryBody slot at the smallest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallSecondaryBody;

  /// Widget to be displayed in the secondaryBody slot at the middle breakpoint.
  ///
  /// The default displayed secondaryBody.
  final WidgetBuilder? secondaryBody;

  /// Widget to be displayed in the secondaryBody slot at the largest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeSecondaryBody;

  final Widget? navigationRailTrailing;

  /// See [Scaffold.floatingActionButton].
  final FloatingActionButton? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// Controls the currently selected index of the [NavigationRail] or
  /// [BottomNavigationBar]. Providing a different [controller]
  /// will also update the scaffold's current active index to the new controller's
  /// index value.
  ///
  /// Defaults to null.
  final AdaptiveScaffoldController? controller;

  /// Defines the appearance of the items that are arrayed within the
  /// navigation.
  ///
  /// The value must be a list of two or more [AdaptiveScaffoldDestination]
  /// values.
  final List<AdaptiveScaffoldDestination> destinations;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Maximum number of items to display in [bottomNavigationBar]
  final int bottomNavigationOverflow;

  final Widget Function(Widget, Animation<double>)? bottomNavigationInAnimation;
  final Widget Function(Widget, Animation<double>)?
      bottomNavigationOutAnimation;
  final Widget Function(Widget, Animation<double>)? navigationRailInAnimation;
  final Widget Function(Widget, Animation<double>)? navigationRailOutAnimation;
  final Widget Function(Widget, Animation<double>)? drawerInAnimation;
  final Widget Function(Widget, Animation<double>)? drawerOutAnimation;

  /// The breakpoint defined for the small size, associated with mobile-like
  /// features.
  ///
  /// Defaults to [Breakpoints.small].
  final Breakpoint smallBreakpoint;

  /// The breakpoint defined for the medium size, associated with tablet-like
  /// features.
  ///
  /// Defaults to [Breakpoints.mediumBreakpoint].
  final Breakpoint mediumBreakpoint;

  /// The breakpoint defined for the large size, associated with desktop-like
  /// features.
  ///
  /// Defaults to [Breakpoints.largeBreakpoint].
  final Breakpoint largeBreakpoint;

  /// Option to override the drawerBreakpoint for the usage of [Drawer] over the
  /// usual [BottomNavigationBar].
  ///
  /// Defaults to [Breakpoints.smallDesktop].
  final Breakpoint drawerBreakpoint;

  /// Option to override the default [AppBar] when using drawer in desktop
  /// small.
  final PreferredSizeWidget? appBar;

  /// Whether to use a [Drawer] over a [BottomNavigationBar] when not on mobile
  /// and Breakpoint is small.
  ///
  /// Defaults to true.
  final bool useDrawer;

  /// Public helper method to be used for creating a [BottomNavigationBar] from
  /// a list of [AdaptiveScaffoldDestinations]s.
  Builder _standardBottomNavigationBar(
    List<AdaptiveScaffoldDestination> destinations,
    int bottomNavigationOverflow,
    AdaptiveScaffoldController controller,
  ) {
    final bottomDestinations = destinations.sublist(
      0,
      math.min(
        destinations.length,
        bottomNavigationOverflow,
      ),
    );

    return Builder(
      builder: (BuildContext context) {
        return NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          destinations: [
            ...bottomDestinations.map(
              (destination) => NavigationDestination(
                icon: destination.icon,
                label: destination.title,
              ),
            )
          ],
          selectedIndex: controller.index,
          onDestinationSelected: (i) => controller.index = i,
        );
      },
    );
  }

  Builder _standardNavigationDrawer(
    List<AdaptiveScaffoldDestination> destinations,
    AdaptiveScaffoldController controller,
  ) {
    return Builder(
      builder: (BuildContext context) {
        return NavigationDrawer(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.background,
          selectedIndex: controller.index,
          onDestinationSelected: (i) => controller.index = i,
          children: [
            ...destinations.map(
              (destination) => NavigationDrawerDestination(
                icon: destination.icon,
                label: Text(destination.title),
              ),
            ),
          ],
        );
      },
    );
  }

  Builder _standardNavigationRail(
    List<AdaptiveScaffoldDestination> destinations,
    AdaptiveScaffoldController controller,
  ) {
    const int railDestinationsOverflow = 7;
    final railDestinations = destinations.sublist(
      0,
      math.min(destinations.length, railDestinationsOverflow),
    );

    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 72,
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        groupAlignment: -.75,
                        trailing: navigationRailTrailing,
                        leading: fabInRail ? floatingActionButton : null,
                        destinations: [
                          ...railDestinations.map(
                            (destination) => NavigationRailDestination(
                              icon: destination.icon,
                              label: Text(destination.title),
                            ),
                          ),
                        ],
                        selectedIndex: controller.index,
                        onDestinationSelected: (i) => controller.index = i,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  AdaptiveScaffoldController? _controller;

  @override
  void initState() {
    super.initState();
    _updateTabController();
  }

  void _updateTabController({bool shouldDisposeOldController = false}) {
    final AdaptiveScaffoldController newController =
        // User provided a new controller, update `_controller` with it.
        widget.controller ?? AdaptiveScaffoldController(initialIndex: 0);

    if (newController == _controller) {
      return;
    }

    if (shouldDisposeOldController) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller?.removeListener(_onCurrentIndexChange);
    }

    newController.addListener(_onCurrentIndexChange);
    _controller = newController;
  }

  void _onCurrentIndexChange() {
    assert(
        _controller!.index >= 0 &&
            _controller!.index < widget.destinations.length,
        "The $runtimeType's current index ${_controller?.index} is "
        'out of bounds for the tab bar with ${widget.destinations.length} tabs');

    // The value of `_controller.index` has already been updated at this point.
    // Calling `setState` to rebuild using `_controller.index`.
    setState(() {});
  }

  @override
  void didUpdateWidget(AdaptiveScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController(
          shouldDisposeOldController: oldWidget.controller == null);
    } else if (_controller!.index >= widget.destinations.length) {
      // If a new [AdaptiveNavigationDestination] with less than
      //(_controller.index + 1) items is provided, clamp the current index.
      _controller!.index = widget.destinations.length - 1;
    }
  }

  @override
  void dispose() {
    // Only dispose `_controller` when the state instance owns it.
    if (widget.controller == null) {
      _controller?.dispose();
    } else if (_controller?._isDisposed == false) {
      _controller?.removeListener(_onCurrentIndexChange);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? AppBar(),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      body: AdaptiveLayout(
        secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig?>{
          Breakpoints.largeDesktop: SlotLayout.from(
            key: const Key('largeDesktopSBody'),
            builder: widget.largeSecondaryBody,
          )
        }),
        internalAnimations: false,
        body: SlotLayout(
          duration: Duration.zero,
          config: <Breakpoint, SlotLayoutConfig?>{
            Breakpoints.standard: SlotLayout.from(
              key: const Key('body'),
              builder: widget.body,
            ),
          },
        ),
        primaryNavigation: SlotLayout(
          duration: const Duration(milliseconds: 250),
          config: <Breakpoint, SlotLayoutConfig>{
            widget.mediumBreakpoint: SlotLayout.from(
              inAnimation: widget.navigationRailInAnimation,
              outAnimation: widget.navigationRailOutAnimation,
              key: const Key('primaryNavigation'),
              builder: (_) => widget._standardNavigationRail(
                widget.destinations,
                _controller!,
              ),
            ),
            widget.largeBreakpoint: SlotLayout.from(
              inAnimation: widget.drawerInAnimation,
              outAnimation: widget.drawerOutAnimation,
              key: const Key('primaryNavigation1'),
              builder: (_) => widget._standardNavigationDrawer(
                widget.destinations,
                _controller!,
              ),
            ),
          },
        ),
        bottomNavigation: SlotLayout(
          duration: const Duration(milliseconds: 100),
          config: <Breakpoint, SlotLayoutConfig>{
            widget.smallBreakpoint: SlotLayout.from(
              inAnimation: widget.bottomNavigationInAnimation,
              outAnimation: widget.bottomNavigationOutAnimation,
              key: const Key('bottomNavigation'),
              builder: (_) => widget._standardBottomNavigationBar(
                widget.destinations,
                widget.bottomNavigationOverflow,
                _controller!,
              ),
            ),
          },
        ),
      ),
    );
  }
}

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [NavigationDrawer],
/// see [NavigationDrawerDestination].
class AdaptiveScaffoldDestination {
  const AdaptiveScaffoldDestination({
    required this.title,
    required this.icon,
    this.selectedIcon,
  });

  /// The text label that appears on the right of the icon
  final String title;

  /// The [Widget] (usually an [Icon]) that's displayed for this
  /// [AdaptiveScaffoldDestination].
  ///
  /// The icon will use [NavigationDrawerThemeData.iconTheme]. If this is
  /// null, the default [IconThemeData] would use a size of 24.0 and
  /// [ColorScheme.onSurfaceVariant].
  final Widget icon;

  /// An alternative icon displayed when this destination is selected.
  ///
  /// If this icon is not provided, the [AdaptiveNavigation] will display [icon]
  /// in either state. The size, color, and opacity of the
  /// [AdaptiveNavigation.selectedIconTheme] will still apply.
  final Widget? selectedIcon;
}

class AdaptiveScaffoldController extends ChangeNotifier {
  AdaptiveScaffoldController({
    int initialIndex = 0,
  })  : _index = initialIndex,
        assert(initialIndex >= 0);

  bool _isDisposed = false;

  int get index => _index;
  int _index;
  set index(int value) {
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
