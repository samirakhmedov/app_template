import 'package:app_template/core/architecture/mixin/lifecycle_observer_mixin.dart';
import 'package:app_template/core/architecture/presentation/core/child_layout.dart';
import 'package:app_template/core/architecture/presentation/core/empty_view_model.dart';
import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/common/presentation/state/shader/shader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// {@template memory_component}
/// A wrapper component which handles memory pressure for app scope.
/// {@endtemplate}
class MemoryComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro memory_component}
  const MemoryComponent({required this.child, super.key});

  /// The subtree of widgets.
  final Widget child;

  @override
  ComponentState<MemoryComponent, EmptyViewModel, ChildLayout> createState() =>
      _SnackQueueComponentState();
}

class _SnackQueueComponentState extends ComponentState<MemoryComponent, EmptyViewModel, ChildLayout>
    with LifecycleObserverMixin {
  @override
  ChildLayout view() => ChildLayout(child: widget.child);

  ShaderBloc get _shaderBloc => context.read<IAppScope>().shaderBloc;

  @override
  void onMemoryPressure() {
    _shaderBloc.add(ShaderEvent.handleMemoryPressure());
  }

  @override
  void onResumed() {
    _shaderBloc.add(ShaderEvent.loadShimmer());
  }
}
