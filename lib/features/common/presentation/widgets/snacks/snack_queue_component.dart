import 'dart:async';

import 'package:app_template/core/architecture/presentation/component.dart';
import 'package:app_template/features/app/di/i_app_scope.dart';
import 'package:app_template/features/common/presentation/state/bloc/snack_queue_bloc.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/default_snack_controller.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/snack_message_type.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/snack_queue_controller.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/snack_queue_layout.dart';
import 'package:app_template/features/common/presentation/widgets/snacks/top_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template snack_queue_component}
/// A component that exposes [SnackQueueController] to its descendants while
/// orchestrating snack queue logic via [SnackQueueBloc].
/// {@endtemplate}
class SnackQueueComponent extends Component<SnackQueueViewModel, SnackQueueLayout> {
  /// {@macro snack_queue_component}
  const SnackQueueComponent({required this.child, super.key});

  /// The subtree that can call [SnackQueueController.addSnack].
  final Widget child;

  /// Returns the [SnackQueueController] from the context.
  static SnackQueueController of(BuildContext context) => context.read<SnackQueueController>();

  @override
  ComponentState<SnackQueueComponent, SnackQueueViewModel, SnackQueueLayout> createState() =>
      _SnackQueueComponentState();
}

class _SnackQueueComponentState
    extends ComponentState<SnackQueueComponent, SnackQueueViewModel, SnackQueueLayout>
    implements SnackQueueViewModel, SnackQueueController {
  late final DefaultSnackController _snackController;

  bool _isShowing = false;

  @override
  void initState() {
    super.initState();

    _snackController = const DefaultSnackController();
  }

  SnackQueueBloc get _bloc => context.read<IAppScope>().snackQueueBloc;


  // Provide BLoC and controller to the subtree.
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
  SnackQueueLayout view() => SnackQueueLayout(viewModel: this);

  // SnackQueueController implementation --------------------------------
  @override
  void addSnack(
    String message, {
    required SnackMessageType messageType,
    EasyDialogDecoration? dialogDecoration,
    EasyDialogAnimationConfiguration? animationConfiguration,
  }) {
    final snack = TopSnackBar(
      message: message,
      messageType: messageType,
      dialogDecoration: dialogDecoration,
      animationConfiguration: animationConfiguration,
    );

    _bloc.add(SnackQueueEvent.add(snack));
  }

  @override
  void clearSnackQueue(DateTime closeTime) {
    _bloc.add(SnackQueueEvent.clear(closeTime));
  }

  Future<void> _showNextSnack(TopSnackBar snack) async {
    _isShowing = true;
    await _snackController
        .showSnack(
          messageType: snack.messageType,
          message: snack.message,
          dialogDecoration: snack.dialogDecoration,
          animationConfiguration: snack.animationConfiguration,
          autoHideDuration: _defaultAutoHideDuration,
        )
        .whenComplete(() {
          _isShowing = false;
          _bloc.add(const SnackQueueEvent.removeFirst());
        });
  }

  // SnackQueueViewModel implementation ---------------------------------
  @override
  Widget get child => widget.child;
}

/// {@template snack_queue_view_model}
/// View-model contract for [SnackQueueComponent].
/// {@endtemplate}
abstract interface class SnackQueueViewModel implements ViewModel, SnackQueueController {
  /// The subtree that will be displayed beneath the component.
  Widget get child;
}

const _defaultAutoHideDuration = Duration(seconds: 3);
