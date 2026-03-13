// ignore_for_file: no-empty-block

import 'package:app_presentation/src/widgets/component.dart';
import 'package:app_presentation/src/widgets/layout.dart';
import 'package:flutter/widgets.dart';

mixin LifecycleObserverMixin<C extends Component<V, L>, V extends ViewModel, L extends Layout<V>>
    on ComponentState<C, V, L> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onResumed() {}

  void onInactive() {}

  void onPaused() {}

  void onDetached() {}

  void onMemoryPressure() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
      case AppLifecycleState.inactive:
        onInactive();
      case AppLifecycleState.paused:
        onPaused();
      case AppLifecycleState.detached:
        onDetached();
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void didHaveMemoryPressure() => onMemoryPressure();
}
