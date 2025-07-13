import 'package:flutter/cupertino.dart';

/// {@template bottom_sheet}
/// Bottom sheet with custom design for entire app.
/// {@endtemplate}
Future<T?> showBottomSheet<T>(
  BuildContext context,
  WidgetBuilder content, {
  bool enableDrag = true,
}) {
  return showCupertinoSheet<T>(
    context: context,
    pageBuilder: content,
    enableDrag: enableDrag,
  );
}
