import 'package:flutter/widgets.dart';

import '../west.dart';

final sizeProvider = StateNotifierProvider<SizeNotifier, Size>(
  (ref) {
    final observer = SizeNotifier();

    WidgetsBinding.instance.addObserver(observer);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));

    return observer;
  },
  name: 'SizeProvider',
);

class SizeNotifier extends StateNotifier<Size> with WidgetsBindingObserver {
  late final ValueChanged<Size> _onSizeChanged;

  SizeNotifier() : super(_getSize()) {
    _onSizeChanged = (value) => state = value;
  }

  @override
  void didChangeMetrics() {
    _onSizeChanged(_getSize());
  }

  static Size _getSize() =>
      WidgetsBinding.instance.window.physicalSize /
      WidgetsBinding.instance.window.devicePixelRatio;
}

//   var pixelRatio = window.devicePixelRatio;

// //Size in physical pixels
//   var physicalScreenSize = window.physicalSize;
//   // var physicalWidth = physicalScreenSize.width;
//   // var physicalHeight = physicalScreenSize.height;

// //Size in logical pixels
//   var logicalScreenSize = window.physicalSize / pixelRatio;
//   // var logicalWidth = logicalScreenSize.width;
//   // var logicalHeight = logicalScreenSize.height;