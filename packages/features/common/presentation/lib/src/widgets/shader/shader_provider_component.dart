import 'dart:async';
import 'dart:ui' as ui;

import 'package:app_presentation/app_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template shader_provider_component}
/// A component that loads and manages fragment shaders, providing them to descendants.
///
/// Place this above any widget that needs access to a fragment shader.
/// Pass asset paths using auto-generated flutter_gen constants.
///
/// Descendants access shaders via:
/// ```dart
/// context.watch<Map<String, ui.FragmentShader?>>()[assetPath]
/// ```
///
/// Example:
/// ```dart
/// ShaderProviderComponent(
///   shaderPaths: const [AppShaders.shimmerFrag],
///   child: ...,
/// )
/// ```
/// {@endtemplate}
class ShaderProviderComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro shader_provider_component}
  const ShaderProviderComponent({
    required this.shaderPaths,
    required this.child,
    super.key,
  });

  /// Asset paths of the shaders to load (use auto-generated flutter_gen constants).
  final List<String> shaderPaths;

  /// The widget subtree that can access the loaded shaders.
  final Widget child;

  @override
  ComponentState<ShaderProviderComponent, EmptyViewModel, ChildLayout> createState() => _ShaderProviderComponentState();
}

class _ShaderProviderComponentState extends ComponentState<ShaderProviderComponent, EmptyViewModel, ChildLayout>
    with LifecycleObserverMixin
    implements EmptyViewModel {
  /// Shaders keyed by asset path. A null value means not yet loaded.
  final _shadersNotifier = ValueNotifier<Map<String, ui.FragmentShader?>>({});

  @override
  void initState() {
    super.initState(); // registers WidgetsBinding observer via LifecycleObserverMixin
    _loadAll();
  }

  @override
  void dispose() {
    _disposeShaders();
    _shadersNotifier.dispose();
    super.dispose(); // unregisters WidgetsBinding observer
  }

  @override
  void onMemoryPressure() {
    _disposeShaders();
    _shadersNotifier.value = {};
    _loadAll();
  }

  void _disposeShaders() {
    for (final shader in _shadersNotifier.value.values) {
      shader?.dispose();
    }
  }

  void _loadAll() {
    for (final path in widget.shaderPaths) {
      unawaited(_loadShader(path));
    }
  }

  Future<void> _loadShader(String path) async {
    try {
      final program = await ui.FragmentProgram.fromAsset(path);
      if (!mounted) return;
      _shadersNotifier.value = {
        ..._shadersNotifier.value,
        path: program.fragmentShader(),
      };
    } on Object catch (_) {
      // Shader unavailable (web / test env) — consumers fall back to gradient.
    }
  }

  @override
  List<SingleChildWidget> providers() => [
    ValueListenableProvider<Map<String, ui.FragmentShader?>>.value(
      value: _shadersNotifier,
    ),
  ];

  @override
  ChildLayout view() => ChildLayout(child: widget.child);
}
