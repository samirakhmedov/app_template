import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:uikit/src/constants.dart';

/// Text widget which accepts and indicates tap by switching opacity.
class LinkText extends StatefulWidget {
  /// [LinkText] constructor.
  const LinkText({
    required this.text,
    required this.style,
    required this.onTap,
    super.key,
  });

  /// Text for tappable widget.
  final String text;

  /// Style of provided [text].
  final TextStyle style;

  /// Callback for tapping on widget.
  final VoidCallback onTap;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  final _gestureRecognizer = TapGestureRecognizer();

  bool _tapped = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _gestureRecognizer.dispose();

    super.dispose();
  }

  void _init() {
    /// Sets up gesture recognizer taps callbacks.
    _gestureRecognizer
      ..onTapUp = (details) {
        _onTapUp();
      }
      ..onTapDown = (details) => _onTapDown();
  }

  /// Reverts opacity animation and runs `onTap` callback
  /// on user lifted up the tap.
  void _onTapUp() {
    setState(() {
      _tapped = false;
    });

    widget.onTap();
  }

  /// Runs opacity animation after user held down on text.
  void _onTapDown() {
    setState(() {
      _tapped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _tapped ? 0.5 : 1.0,
      duration: kDefaultAnimationDuration,
      child: Text.rich(
        TextSpan(
          text: widget.text,
          style: widget.style,
          recognizer: _gestureRecognizer,
          mouseCursor: MouseCursor.defer,
        ),
      ),
    );
  }
}
