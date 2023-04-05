import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final platformBrightnessProvider =
    StateNotifierProvider<PlatformBrightnessObserver, Brightness>(
  (ref) {
    final observer = PlatformBrightnessObserver();

    WidgetsBinding.instance.addObserver(observer);
    ref.onDispose(() => WidgetsBinding.instance.removeObserver(observer));

    return observer;
  },
  name: 'PlatformBrightnessProvider',
);

class PlatformBrightnessObserver extends StateNotifier<Brightness>
    with WidgetsBindingObserver {
  late final ValueChanged<Brightness> _onBrightnessChanged;

  PlatformBrightnessObserver() : super(_getBrightness()) {
    _onBrightnessChanged = (value) => state = value;
  }

  @override
  void didChangePlatformBrightness() => _onBrightnessChanged(_getBrightness());

  static Brightness _getBrightness() =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
}
