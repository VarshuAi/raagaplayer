import 'package:flutter/widgets.dart';

abstract class AppLifecycleListener {
  void onAppPaused();
  void onAppResumed();
  void onAppDetached();
  void onAppInactive();
}

class AppLifecycleManager extends WidgetsBindingObserver {
  static final AppLifecycleManager _instance = AppLifecycleManager._internal();
  factory AppLifecycleManager() => _instance;
  AppLifecycleManager._internal();

  final List<AppLifecycleListener> _listeners = [];

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  void addListener(AppLifecycleListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(AppLifecycleListener listener) {
    _listeners.remove(listener);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        for (final listener in _listeners) {
          listener.onAppPaused();
        }
        break;
      case AppLifecycleState.resumed:
        for (final listener in _listeners) {
          listener.onAppResumed();
        }
        break;
      case AppLifecycleState.detached:
        for (final listener in _listeners) {
          listener.onAppDetached();
        }
        break;
      case AppLifecycleState.inactive:
        for (final listener in _listeners) {
          listener.onAppInactive();
        }
        break;
      default:
        break;
    }
  }
}
