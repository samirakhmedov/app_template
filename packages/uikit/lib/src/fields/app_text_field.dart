import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/uikit.dart';

/// Поле для ввода текста.
class AppTextField extends StatefulWidget {
  /// Создать экземпляр [AppTextField].
  const AppTextField({
    this.fieldKey,
    this.decoration,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
    this.saveFocusOnOutsideTap = false,
    this.enableInteractiveSelection = true,
    this.obscureText = false,
    this.actions = const [],
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.validateOnLostFocusIfInteracted = false,
    this.textInputAction,
    this.onEditingComplete,
    this.autoFillHints,
    this.initialValue,
    this.maxLength,
    this.autofocus = false,
    super.key,
    this.scrollPadding,
  }) : assert(minLines == null || minLines > 0),
       assert(maxLines == null || maxLines > 0),
       assert(
         (minLines == null) || (maxLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(
         !validateOnLostFocusIfInteracted || validateOnLostFocusIfInteracted && fieldKey != null,
         'fieldKey is required for on lost focus validation',
       );

  /// Global key to access [FormFieldState].
  final GlobalKey<FormFieldState<String>>? fieldKey;

  /// If need to validate field on lost focus after user interaction.
  // ignore: prefer-correct-identifier-length
  final bool validateOnLostFocusIfInteracted;

  /// [TextEditingController].
  final TextEditingController? controller;

  /// Initial text field value.
  final String? initialValue;

  /// Padding for input when focused.
  final EdgeInsets? scrollPadding;

  /// Включить интерактивное выделение текста.
  final bool enableInteractiveSelection;

  /// [FocusNode].
  final FocusNode? focusNode;

  /// Сохранять фокус при тапе вне поля.
  final bool saveFocusOnOutsideTap;

  /// Колбек изменения значения в поле.
  final ValueChanged<String>? onChanged;

  /// Autofill hints.
  final List<String>? autoFillHints;

  /// Включено ли поле.
  final bool enabled;

  /// Максимальное число линий текста.
  final int? maxLines;

  /// Минимальное число линий текста.
  final int? minLines;

  /// Maximum amount of length in input.
  final int? maxLength;

  /// Тип вводимых символов.
  final TextInputType? keyboardType;

  /// Нужно ли скрывать текст.
  final bool obscureText;

  /// Форматеры.
  final List<TextInputFormatter>? inputFormatters;

  /// Конфигурация UI для поля ввода.
  final InputDecoration? decoration;

  /// Валидатор поля.
  final FormFieldValidator<String>? validator;

  /// Набор виджетов, которые помещаются в правую часть поля ввода.
  ///
  /// Например, иконка очистки поля.
  final List<Widget> actions;

  /// Text capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Text input action.
  final TextInputAction? textInputAction;

  /// On editing complete action.
  final VoidCallback? onEditingComplete;

  /// Manage keyboard focus.
  final bool autofocus;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focus;
  late bool _validatedAfterLostFocus;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(focusListener);
    _validatedAfterLostFocus = false;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  /// Listens focus events for this field.
  /// Runs field validation on lost focus if validateOnLostFocusIfInteracted is true.
  void focusListener() {
    if (!widget.validateOnLostFocusIfInteracted) return;

    if (!_focus.hasFocus) {
      final fieldWasInteracted = widget.fieldKey?.currentState?.hasInteractedByUser ?? false;

      if (fieldWasInteracted) {
        widget.fieldKey?.currentState?.validate();

        /// Set _validatedAfterLostFocus flag value to true.
        _validatedAfterLostFocus = true;
      }
    }
  }

  /// Handles change of value of this field.
  /// Runs field validation if _validatedAfterLostFocus is true.
  void handleChanged(String value) {
    /// Validate field value after each update if it have been already validated on lost focus previously.
    if (_validatedAfterLostFocus) {
      widget.fieldKey?.currentState?.validate();
    }

    /// Call on changed callback if present.
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.appColorScheme;
    final disabled = !widget.enabled;
    final decoration = widget.decoration ?? const InputDecoration();
    final fillColor = disabled
        ? colorScheme.inactive
        : (decoration.fillColor ?? colorScheme.background);

    return TextFormField(
      key: widget.fieldKey,
      controller: _controller,
      focusNode: _focus,
      decoration: decoration.copyWith(
        helperStyle: TextStyle(color: colorScheme.inactive),
        contentPadding: EdgeInsets.all(context.appSizesScheme.paddingGeneral),
        suffixIcon: IconButtonTheme(
          data: IconButtonThemeData(
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(
                disabled ? colorScheme.inactive : colorScheme.onSurface,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.actions,
          ),
        ),
        fillColor: fillColor,
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      onChanged: handleChanged,
      onTapOutside: widget.saveFocusOnOutsideTap ? null : (_) => _focus.unfocus(),
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorHeight: context.appSizesScheme.cursorHeightGeneral,
      scrollPadding: widget.scrollPadding ?? EdgeInsets.all(context.appSizesScheme.paddingGeneral),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      buildCounter:
          (
            ctx, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) => const SizedBox(),
      autofillHints: widget.autoFillHints,
    );
  }
}
