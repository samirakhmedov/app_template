import 'dart:async';

import 'package:app_template/core/architecture/mixin/theme_mixin.dart';
import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/core/config/urls.dart';
import 'package:app_template/features/app/router/app_router.dart';
import 'package:app_template/features/debug/presentation/screens/debug/debug_settings_layout.dart';
import 'package:app_template/features/debug/presentation/state/bloc/debug_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template debug_component}
/// A component for the debug screen.
/// {@endtemplate}
@RoutePage()
class DebugSettingsComponent extends Component<DebugViewModel, DebugSettingsLayout> {
  /// {@macro debug_component}
  const DebugSettingsComponent({super.key});

  @override
  ComponentState<DebugSettingsComponent, DebugViewModel, DebugSettingsLayout> createState() =>
      _DebugComponentState();
}

class _DebugComponentState
    extends ComponentState<DebugSettingsComponent, DebugViewModel, DebugSettingsLayout>
    with ThemeMixin
    implements DebugViewModel {
  DebugBloc get _debugBloc => context.read<DebugBloc>();

  @override
  DebugSettingsLayout view() => DebugSettingsLayout(viewModel: this);

  @override
  void setBaseUri(Urls? url) {
    if (url == null) {
      return;
    }

    _debugBloc.add(DebugSetBaseUrl(baseUrl: url));
  }

  @override
  void openEasterEgg() {
    unawaited(context.router.push(const EasterEggRoute()));
  }

  @override
  StateStreamable<DebugState> get debugBloc => _debugBloc;

  @override
  String get easterEgg => 'I am used to tesk mocking possibilities!';
}

/// {@template debug_view_model}
/// A view model for the debug screen.
/// {@endtemplate}
abstract class DebugViewModel implements ViewModel, ThemeVM {
  /// The debug bloc.
  StateStreamable<DebugState> get debugBloc;

  /// Easter egg title.
  ///
  /// Used for mock purposes.
  String get easterEgg;

  /// Sets the base uri.
  void setBaseUri(Urls? url);

  /// Opens the easter egg.
  void openEasterEgg();
}
