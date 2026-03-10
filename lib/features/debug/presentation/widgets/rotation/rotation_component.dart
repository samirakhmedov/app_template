import 'dart:async';
import 'dart:math';

import 'package:app_template/core/architecture/presentation/state/restorable_value_notifier.dart';
import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/features/debug/presentation/widgets/rotation/rotation_layout.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptics_component.dart';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// {@template rotation_component}
/// A component for the rotation widget.
/// {@endtemplate}
class RotationComponent extends Component<RotationViewModel, RotationLayout> {
  /// {@macro rotation_component}
  const RotationComponent({
    required this.child,
    required this.rotationTargetKey,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The key of the widget to be rotated.
  final GlobalKey rotationTargetKey;

  /// Returns the [IRotationProvider] from the context.
  static IRotationProvider of(BuildContext context) {
    return context.read<IRotationProvider>();
  }

  @override
  ComponentState<RotationComponent, RotationViewModel, RotationLayout> createState() =>
      _RotationComponentState();
}

class _RotationComponentState
    extends ComponentState<RotationComponent, RotationViewModel, RotationLayout>
    with TickerProviderStateMixin, RestorationMixin
    implements RotationViewModel, IRotationProvider {
  late final _angleState = DoubleValueNotifier(0);

  final _cache = AsyncCache.ephemeral();

  int _lastHapticSegment = 0;
  Ticker? _momentumTicker;
  double _angularVelocity = 0;
  double? _lastAngle;
  int? _lastTimestamp;

  int? _lastMomentumTimestamp;

  @override
  void dispose() {
    _angleState.dispose();
    _momentumTicker?.dispose();
    super.dispose();
  }

  @override
  void onPanStart(DragStartDetails details) {
    _momentumTicker?.stop();
    _lastAngle = null;
    _lastTimestamp = null;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    final logoContext = widget.rotationTargetKey.currentContext;
    if (logoContext == null) return;
    final box = logoContext.findRenderObject() as RenderBox?;
    if (box == null) return;

    final center = box.localToGlobal(box.size.center(Offset.zero));
    final currentAngle = atan2(
      details.globalPosition.dy - center.dy,
      details.globalPosition.dx - center.dx,
    );

    final now = DateTime.now().millisecondsSinceEpoch;
    final lastAngle = _lastAngle;
    final lastTimestamp = _lastTimestamp;
    if (lastAngle != null && lastTimestamp != null) {
      var deltaAngle = currentAngle - lastAngle;
      if (deltaAngle.abs() > pi) {
        deltaAngle -= deltaAngle.sign * 2 * pi;
      }
      _angleState.value += deltaAngle;

      final deltaTime = now - lastTimestamp;
      if (deltaTime > 1) {
        final currentVelocity = deltaAngle / deltaTime;
        _angularVelocity = _angularVelocity * 0.6 + currentVelocity * 0.4;
      }
    }

    _lastAngle = currentAngle;
    _lastTimestamp = now;

    _performHapticFeedback(_angleState.value);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    unawaited(
      _cache.fetch(() async {
        _lastMomentumTimestamp = DateTime.now().millisecondsSinceEpoch;
        _momentumTicker?.stop();
        _momentumTicker?.dispose();

        final completer = Completer();

        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            _momentumTicker = createTicker(_handleMomentumTick);

            unawaited(_momentumTicker?.start());

            completer.complete();
          },
        );

        return completer.future;
      }),
    );
  }

  @override
  List<SingleChildWidget> providers() {
    return [
      Provider<IRotationProvider>.value(value: this),
    ];
  }

  @override
  RotationLayout view() => RotationLayout(viewModel: this);

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_angleState, _ResorationKeys.angle.key);
  }

  void _handleMomentumTick(Duration elapsed) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final deltaTimeMs = now - (_lastMomentumTimestamp ?? now);
    _lastMomentumTimestamp = now;

    if (deltaTimeMs <= 0) return;

    const friction = 2.0;
    _angularVelocity *= 1 - friction * (deltaTimeMs / 1000.0);

    if (_angularVelocity.abs() < 0.0001) {
      _momentumTicker?.stop();

      return;
    }

    final newAngle = _angleState.value + _angularVelocity * deltaTimeMs;
    _angleState.value = newAngle;

    _performHapticFeedback(newAngle);
  }

  void _performHapticFeedback(double angle) {
    const hapticAngleStep = pi / 6;
    final normalizedAngle = (angle + pi) % (pi * 2);
    final currentSegment = (normalizedAngle / hapticAngleStep).floor();

    if (currentSegment != _lastHapticSegment) {
      HapticsComponent.of(context).selection();
      _lastHapticSegment = currentSegment;
    }
  }

  @override
  ValueListenable<double> get angleState => _angleState;

  @override
  Widget get child => widget.child;

  @override
  String get restorationId => _ResorationKeys.rotationTargetKey.key;
}

/// {@template i_rotation_provider}
/// A provider for the rotation.
/// {@endtemplate}
abstract interface class IRotationProvider {
  /// The angle state.
  ValueListenable<double> get angleState;
}

/// {@template rotation_view_model}
/// A view model for the rotation widget.
/// {@endtemplate}
abstract class RotationViewModel implements ViewModel {
  /// The child widget.
  Widget get child;

  /// The on pan start callback.
  void onPanStart(DragStartDetails details);

  /// The on pan update callback.
  void onPanUpdate(DragUpdateDetails details);

  /// The on pan end callback.
  void onPanEnd(DragEndDetails details);
}

enum _ResorationKeys {
  angle('angle'),
  rotationTargetKey('rotation_target_key')
  ;

  final String key;

  const _ResorationKeys(this.key);
}

/// A [RestorableValueNotifier] for [double] values.
class DoubleValueNotifier extends RestorableValueNotifier<double> {
  /// {@macro restorable_value_notifier}
  DoubleValueNotifier(super.defaultValue);

  @override
  double fromPrimitives(Object? data) {
    if (data is double) {
      return data;
    }

    return 0;
  }

  @override
  // ignore: avoid-unnecessary-nullable-return-type, no-object-declaration
  Object? toPrimitives() {
    return value;
  }
}
