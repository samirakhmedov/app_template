import 'package:app_presentation/app_presentation.dart';
import 'package:core/core.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:debug_presentation/debug_presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template debug_component}
/// A component for the debug screen.
/// {@endtemplate}
class DebugSettingsComponent extends Component<DebugViewModel, DebugLayout> {
  /// {@macro debug_component}
  const DebugSettingsComponent({required this.onOpenEasterEgg, super.key});

  /// Called when the user triggers navigation to the easter egg screen.
  final VoidCallback onOpenEasterEgg;

  @override
  ComponentState<DebugSettingsComponent, DebugViewModel, DebugLayout> createState() => _DebugSettingsComponentState();
}

class _DebugSettingsComponentState extends ComponentState<DebugSettingsComponent, DebugViewModel, DebugLayout>
    with ThemeMixin
    implements DebugViewModel {
  DebugBloc get _debugBloc => context.read<DebugBloc>();

  @override
  DebugLayout view() => DebugLayout(viewModel: this);

  @override
  void setBaseUri(Urls? url) {
    if (url == null) {
      return;
    }

    _debugBloc.add(DebugSetBaseUrl(baseUrl: url));
  }

  @override
  void openEasterEgg() => widget.onOpenEasterEgg();

  @override
  StateStreamable<DebugState> get debugBloc => _debugBloc;

  @override
  String get easterEgg => 'I am used to test mocking possibilities!';
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
