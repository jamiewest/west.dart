import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:west/theme/west_theme.dart';
import 'package:west/ui/layout/adaptive_scaffold.dart';
import 'package:west/ui/layout/breakpoints.dart';
import 'package:west/west.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: ref.watch(routesProvider),
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
  ),
);

final scaffoldControllerProvider = Provider(
  name: 'ScaffoldControllerProvider',
  (ref) => AdaptiveScaffoldController(),
);

final routesProvider = Provider(
  (ref) => [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AdaptiveScaffold(
        controller: ref.watch(scaffoldControllerProvider),
        appBar: AppBar(title: const WindowSize()),
        body: (_) => child,
        // largeSecondaryBody: (c) =>
        //     SecondComponentList(scaffoldKey: GlobalKey<ScaffoldState>()),
        useDrawer: false,
        largeBreakpoint: const WidthPlatformBreakpoint(begin: 1201),
        mediumBreakpoint: const WidthPlatformBreakpoint(begin: 769, end: 1200),
        smallBreakpoint: const WidthPlatformBreakpoint(begin: 0, end: 768),
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Components',
            icon: Icon(Icons.abc_rounded),
            selectedIcon: Icon(Icons.abc_rounded),
          ),
          AdaptiveScaffoldDestination(
            title: 'Color',
            icon: Icon(Icons.abc_rounded),
            selectedIcon: Icon(Icons.abc_rounded),
          ),
          AdaptiveScaffoldDestination(
            title: 'Typography',
            icon: Icon(Icons.abc_rounded),
            selectedIcon: Icon(Icons.abc_rounded),
          ),
          AdaptiveScaffoldDestination(
            title: 'Elevation',
            icon: Icon(Icons.abc_rounded),
            selectedIcon: Icon(Icons.abc_rounded),
          ),
        ],
      ),
      routes: [
        GoRoute(
          name: 'Components',
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FirstComponentList1(),
          ),
        ),
        GoRoute(
          name: 'Colors',
          path: '/colors',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ColorPalettesScreen(),
          ),
        ),
        GoRoute(
          name: 'Typography',
          path: '/typography',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TypographyScreen(),
          ),
        ),
        GoRoute(
          name: 'Elevation',
          path: '/elevation',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ElevationScreen(),
          ),
        ),
      ],
    )
  ],
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  late final AdaptiveScaffoldController _controller;

  @override
  void initState() {
    _controller = ref.read(scaffoldControllerProvider);
    _controller.addListener(() {
      if (_controller.index == 0) {
        ref.read(routerProvider).goNamed('Components');
      } else if (_controller.index == 1) {
        ref.read(routerProvider).goNamed('Colors');
      } else if (_controller.index == 2) {
        ref.read(routerProvider).goNamed('Typography');
      } else if (_controller.index == 3) {
        ref.read(routerProvider).goNamed('Elevation');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Material 3',
      theme: ref.watch(
        themeProvider(
          (scale) => WestTheme(
            scale: scale,
            colorScheme: ColorScheme.fromSeed(
              brightness: ref.watch(platformBrightnessProvider),
              seedColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class WindowSize extends ConsumerWidget {
  const WindowSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final scale = ref.read(scaleProvider);
    debugPrint('screenSize=$screenSize, scale=${ref.watch(scaleProvider)}');

    return Text(
        'Width : ${MediaQuery.of(context).size.width} Height : ${MediaQuery.of(context).size.height} Scale : $scale');
  }
}

// final themeProvider = Provider.family<ThemeData, Size?>((ref, size) {
//   var pixelRatio = window.devicePixelRatio;

// //Size in physical pixels
//   var physicalScreenSize = window.physicalSize;
//   // var physicalWidth = physicalScreenSize.width;
//   // var physicalHeight = physicalScreenSize.height;

// //Size in logical pixels
//   var logicalScreenSize = window.physicalSize / pixelRatio;
//   // var logicalWidth = logicalScreenSize.width;
//   // var logicalHeight = logicalScreenSize.height;

//   return WestTheme(
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Colors.blue,
//       brightness: ref.watch(platformBrightnessProvider),
//     ),
//   ).data;
// });
