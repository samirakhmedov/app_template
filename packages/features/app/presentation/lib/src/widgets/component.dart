// ignore_for_file: avoid-returning-widgets

import 'package:app_presentation/src/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class Component<V extends ViewModel, L extends Layout<V>> extends StatefulWidget with WidgetsBindingObserver {
  const Component({super.key});

  @override
  ComponentState<Component<V, L>, V, L> createState();
}

abstract class ComponentState<C extends Component<V, L>, V extends ViewModel, L extends Layout<V>> extends State<C>
    with WidgetsBindingObserver {
  ComponentState();

  List<BlocListenerType> listeners() => [];

  List<SingleChildWidget> providers() => [];

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

abstract interface class ViewModel {}

typedef BlocListenerType = BlocListenerBase<StateStreamable<Object?>, Object?>;
