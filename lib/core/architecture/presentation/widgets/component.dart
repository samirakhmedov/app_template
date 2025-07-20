// ignore_for_file: avoid-returning-widgets

import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template component}
/// A component is a widget that contains a view model and a layout.
/// {@endtemplate}
abstract class Component<V extends ViewModel, L extends Layout<V>> extends StatefulWidget
    with WidgetsBindingObserver {
  /// {@macro component}
  const Component({super.key});

  @override
  ComponentState<Component<V, L>, V, L> createState();
}

/// {@template component_state}
/// A state for a component.
/// {@endtemplate}
abstract class ComponentState<C extends Component<V, L>, V extends ViewModel, L extends Layout<V>>
    extends State<C>
    with WidgetsBindingObserver {
  /// {@macro component_state}
  ComponentState();

  /// A list of listeners to be added to the component.
  List<BlocListenerType> listeners() => [];

  /// A list of providers to be added to the component.
  List<SingleChildWidget> providers() => [];

  /// A function that returns a layout for the component.
  L view();

  @override
  Widget build(BuildContext context) {
    Widget view = this.view();

    final listeners = this.listeners();

    if (listeners.isNotEmpty) {
      view = MultiBlocListener(listeners: listeners, child: view);
    }

    final providers = this.providers();

    if (providers.isNotEmpty) {
      view = MultiProvider(providers: providers, child: view);
    }

    return view;
  }
}

/// {@template view_model}
/// A view model is a class that contains the state of the component.
/// {@endtemplate}
abstract interface class ViewModel {}

/// {@template bloc_listener_type}
/// A type for a bloc listener.
/// {@endtemplate}
typedef BlocListenerType = BlocListenerBase<StateStreamable<Object?>, Object?>;
