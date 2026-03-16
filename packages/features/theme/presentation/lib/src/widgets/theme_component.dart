import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:theme_domain/theme_domain.dart';
import 'package:theme_presentation/src/widgets/theme_layout.dart';

/// {@template theme_component}
/// A component for the theme screen.
/// {@endtemplate}
class ThemeComponent extends Component<ThemeViewModel, ThemeLayout> {
  /// {@macro theme_component}
  const ThemeComponent({
    required this.child,
    required this.lightTheme,
    required this.darkTheme,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The light theme.
  final ThemeData lightTheme;

  /// The dark theme.
  final ThemeData darkTheme;

  /// Returns the [IThemeModeProvider] from the context.
  static IThemeModeProvider of(BuildContext context) {
    return context.read<IThemeModeProvider>();
  }

  @override
  ComponentState<ThemeComponent, ThemeViewModel, ThemeLayout> createState() =>
      _ThemeComponentState();
}

class _ThemeComponentState extends ComponentState<ThemeComponent, ThemeViewModel, ThemeLayout>
    implements ThemeViewModel, IThemeModeProvider {
  late final ValueNotifier<ThemeMode> _themeNotifier;

  ThemeBloc get _themeBloc => context.read<ThemeBloc>();

  @override
  void initState() {
    super.initState();
    _themeNotifier = ValueNotifier(_themeBloc.state.themeMode);
  }

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  List<BlocListenerType> listeners() {
    return [
      BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          _themeNotifier.value = state.themeMode;
        },
        bloc: _themeBloc,
      ),
    ];
  }

  @override
  void setThemeMode(ThemeMode mode) {
    _themeBloc.add(ThemeSetMode(mode));
  }

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<IThemeModeProvider>.value(value: this),
    ];
  }

  @override
  ThemeLayout view() {
    return ThemeLayout(viewModel: this);
  }

  @override
  ThemeData get lightTheme => widget.lightTheme;

  @override
  ThemeData get darkTheme => widget.darkTheme;

  @override
  Widget get child => widget.child;

  @override
  ValueListenable<ThemeMode> get themeMode => _themeNotifier;

  @override
  StateStreamable<ThemeState> get themeBloc => _themeBloc;
}

/// {@template i_theme_mode_provider}
/// A provider for the theme mode.
/// {@endtemplate}
abstract interface class IThemeModeProvider {
  /// The theme mode.
  ValueListenable<ThemeMode> get themeMode;

  /// Sets the theme mode.
  void setThemeMode(ThemeMode mode);
}

/// {@template theme_view_model}
/// A view model for the theme screen.
/// {@endtemplate}
abstract interface class ThemeViewModel implements ViewModel {
  /// The light theme.
  ThemeData get lightTheme;

  /// The dark theme.
  ThemeData get darkTheme;

  /// The bloc providing theme state.
  StateStreamable<ThemeState> get themeBloc;

  /// The child widget.
  Widget get child;
}
