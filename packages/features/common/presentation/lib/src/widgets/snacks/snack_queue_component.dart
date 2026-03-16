import 'dart:async';

import 'package:app_presentation/app_presentation.dart';
import 'package:common_domain/common_domain.dart';
import 'package:common_presentation/src/widgets/snacks/default_snack_controller.dart';
import 'package:common_presentation/src/widgets/snacks/snack_queue_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template snack_queue_component}
/// A component that exposes [SnackQueueController] to its descendants while
/// orchestrating snack queue logic via [SnackQueueBloc].
/// {@endtemplate}
class SnackQueueComponent extends Component<EmptyViewModel, ChildLayout> {
  /// {@macro snack_queue_component}
  const SnackQueueComponent({required this.child, super.key});

  /// The subtree that can call [SnackQueueController.addSnack].
  final Widget child;

  /// Returns the [SnackQueueController] from the context.
  static SnackQueueController of(BuildContext context) => context.read<SnackQueueController>();

  @override
  ComponentState<SnackQueueComponent, EmptyViewModel, ChildLayout> createState() =>
      _SnackQueueComponentState();
}

class _SnackQueueComponentState
    extends ComponentState<SnackQueueComponent, EmptyViewModel, ChildLayout>
    implements EmptyViewModel, SnackQueueController {
  late final DefaultSnackController _snackController;

  bool _isShowing = false;

  @override
  void initState() {
    super.initState();

    _snackController = const DefaultSnackController();
  }

  SnackQueueBloc get _bloc => context.read<SnackQueueBloc>();

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<SnackQueueController>.value(value: this),
    ];
  }

  @override
  List<BlocListenerType> listeners() {
    return [
      BlocListener<SnackQueueBloc, SnackQueueState>(
        // ignore: prefer-extracting-callbacks
        listener: (context, state) {
          if (_isShowing) return;

          if (state.queue.isEmpty) return;

          final snack = state.queue.firstOrNull;

          if (snack == null) return;

          unawaited(_showNextSnack(snack));
        },
        bloc: _bloc,
      ),
    ];
  }

  @override
  void addSnack(
    String message, {
    required SnackMessageType messageType,
  }) {
    final snack = SnackData(
      message: message,
      messageType: messageType,
      showTime: DateTime.now(),
    );

    _bloc.add(SnackQueueEvent.add(snack));
  }

  @override
  void clearSnackQueue(DateTime closeTime) {
    _bloc.add(SnackQueueEvent.clear(closeTime));
  }

  @override
  ChildLayout view() => ChildLayout(child: widget.child);

  Future<void> _showNextSnack(SnackData snack) async {
    _isShowing = true;
    await _snackController
        .showSnack(
          messageType: snack.messageType,
          message: snack.message,
          autoHideDuration: _defaultAutoHideDuration,
        )
        .whenComplete(() {
          _isShowing = false;
          _bloc.add(const SnackQueueEvent.removeFirst());
        });
  }
}

const _defaultAutoHideDuration = Duration(seconds: 3);
