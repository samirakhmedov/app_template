import 'package:app_presentation/app_presentation.dart';
import 'package:common_domain/common_domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template memory_component}
/// A wrapper component that handles memory pressure and app lifecycle events
/// for [MemoryBloc].
///
/// Place this above any widget that needs the database to be revived on app
/// resume or to be cleaned up on memory pressure.
/// {@endtemplate}
class MemoryComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro memory_component}
  const MemoryComponent({required this.child, super.key});

  /// The widget subtree.
  final Widget child;

  @override
  ComponentState<MemoryComponent, EmptyViewModel, ChildLayout> createState() => _MemoryComponentState();
}

class _MemoryComponentState extends ComponentState<MemoryComponent, EmptyViewModel, ChildLayout>
    with LifecycleObserverMixin
    implements EmptyViewModel {
  MemoryBloc get _bloc => context.read<MemoryBloc>();

  @override
  void onMemoryPressure() => _bloc.add(const MemoryEvent.handleMemoryPressure());

  @override
  void onResumed() => _bloc.add(const MemoryEvent.revive());

  @override
  ChildLayout view() => ChildLayout(child: widget.child);
}
