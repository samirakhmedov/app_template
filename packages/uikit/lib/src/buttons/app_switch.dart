import 'package:flutter/material.dart';
import 'package:uikit/src/colors/app_color_scheme.dart';
import 'package:uikit/src/sizes/app_sizes_scheme.dart';

/// {@template app_switch.dart}
/// App Switch.
/// {@endtemplate}
class AppSwitch extends StatelessWidget {
  /// {@macro app_switch.dart}
  const AppSwitch({required this.value, this.onSwitch, super.key});

  /// Switch state.
  final bool value;

  /// [ValueChanged] for switch.
  final ValueChanged<bool>? onSwitch;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.appColorScheme;

    final activeTrackColor = colorScheme.primary;
    final inactiveTrackColor = colorScheme.primary.withValues(alpha: 0.5);

    return SizedBox(
      height: context.appSizesScheme.iconSizeMassive,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Switch(
          value: value,
          onChanged: onSwitch,
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: inactiveTrackColor,
          thumbColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          trackOutlineColor: WidgetStatePropertyAll(
            colorScheme.onPrimary.withValues(alpha: 0.08),
          ),
          trackOutlineWidth: WidgetStatePropertyAll(
            context.appSizesScheme.strokeGeneral,
          ),
          thumbIcon: WidgetStateProperty.resolveWith<Icon>(
            (_) => Icon(
              Icons.circle,
              size: context.appSizesScheme.iconSizeMassive,
              color: colorScheme.onPrimary,
            ),
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
