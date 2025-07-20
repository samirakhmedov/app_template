import 'package:app_template/core/architecture/presentation/widgets/component.dart';
import 'package:app_template/features/debug/presentation/widgets/drag/drag_layout.dart';
import 'package:app_template/features/haptics/presentation/widgets/haptics_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:haptics/haptics.dart';

/// {@template drag_component}
/// A component for the drag widget.
/// {@endtemplate}
class DragComponent extends Component<DragViewModel, DragLayout> {
  /// {@macro drag_component}
  const DragComponent({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  @override
  ComponentState<DragComponent, DragViewModel, DragLayout> createState() => _DragComponentState();
}

class _DragComponentState extends ComponentState<DragComponent, DragViewModel, DragLayout>
    with SingleTickerProviderStateMixin
    implements DragViewModel {
  late final AnimationController _controller;
  late final CurvedAnimation _curvedAnimation;

  final _offset = ValueNotifier<Offset>(Offset.zero);

  final _isDragging = ValueNotifier<bool>(false);

  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _offsetAnimation = AlwaysStoppedAnimation(Offset.zero);

    _controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerUpdate)
      ..dispose();
    _curvedAnimation.dispose();
    _isDragging.dispose();
    _offset.dispose();
    super.dispose();
  }

  @override
  void onPanStart(DragStartDetails details) {
    _controller.stop();
    final box = context.findRenderObject() as RenderBox?;

    if (box == null) {
      return;
    }

    final localPosition = box.globalToLocal(details.globalPosition);

    _isDragging.value = box.size.contains(localPosition);

    if (_isDragging.value) {
      HapticsComponent.of(context).feedback(HapticFeedbackType.gestureStart);
    }
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    _offset.value += details.delta;
  }

  @override
  void onPanEnd(DragEndDetails details) {
    _offsetAnimation = Tween<Offset>(
      begin: _offset.value,
      end: Offset.zero,
    ).animate(_curvedAnimation);

    _controller.forward(from: 0);

    _isDragging.value = false;

    HapticsComponent.of(context).feedback(HapticFeedbackType.gestureEnd);
  }

  @override
  DragLayout view() => DragLayout(viewModel: this);

  void _onControllerUpdate() {
    _offset.value = _offsetAnimation.value;
  }

  @override
  ValueListenable<bool> get isDragging => _isDragging;

  @override
  ValueListenable<Offset> get offsetAnimation => _offset;

  @override
  Widget get child => widget.child;
}

/// {@template drag_view_model}
/// A view model for the drag widget.
/// {@endtemplate}
abstract class DragViewModel implements ViewModel {
  /// The offset animation.
  ValueListenable<Offset> get offsetAnimation;

  /// The is dragging value.
  ValueListenable<bool> get isDragging;

  /// The child widget.
  Widget get child;

  /// The on pan start callback.
  void onPanStart(DragStartDetails details);

  /// The on pan update callback.
  void onPanUpdate(DragUpdateDetails details);

  /// The on pan end callback.
  void onPanEnd(DragEndDetails details);
}
