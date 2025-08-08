// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_button_scheme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppButtonSchemeTailorMixin on ThemeExtension<AppButtonScheme> {
  ButtonStyle get primaryLarge;
  ButtonStyle get primaryMedium;
  ButtonStyle get primarySmall;
  ButtonStyle get transparentLarge;
  ButtonStyle get transparentMedium;
  ButtonStyle get transparentSmall;
  ButtonStyle get primaryIcon;

  @override
  AppButtonScheme copyWith({
    ButtonStyle? primaryLarge,
    ButtonStyle? primaryMedium,
    ButtonStyle? primarySmall,
    ButtonStyle? transparentLarge,
    ButtonStyle? transparentMedium,
    ButtonStyle? transparentSmall,
    ButtonStyle? primaryIcon,
  }) {
    return AppButtonScheme(
      primaryLarge: primaryLarge ?? this.primaryLarge,
      primaryMedium: primaryMedium ?? this.primaryMedium,
      primarySmall: primarySmall ?? this.primarySmall,
      transparentLarge: transparentLarge ?? this.transparentLarge,
      transparentMedium: transparentMedium ?? this.transparentMedium,
      transparentSmall: transparentSmall ?? this.transparentSmall,
      primaryIcon: primaryIcon ?? this.primaryIcon,
    );
  }

  @override
  AppButtonScheme lerp(
    covariant ThemeExtension<AppButtonScheme>? other,
    double t,
  ) {
    if (other is! AppButtonScheme) return this as AppButtonScheme;
    return AppButtonScheme(
      primaryLarge: t < 0.5 ? primaryLarge : other.primaryLarge,
      primaryMedium: t < 0.5 ? primaryMedium : other.primaryMedium,
      primarySmall: t < 0.5 ? primarySmall : other.primarySmall,
      transparentLarge: t < 0.5 ? transparentLarge : other.transparentLarge,
      transparentMedium: t < 0.5 ? transparentMedium : other.transparentMedium,
      transparentSmall: t < 0.5 ? transparentSmall : other.transparentSmall,
      primaryIcon: t < 0.5 ? primaryIcon : other.primaryIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppButtonScheme &&
            const DeepCollectionEquality().equals(
              primaryLarge,
              other.primaryLarge,
            ) &&
            const DeepCollectionEquality().equals(
              primaryMedium,
              other.primaryMedium,
            ) &&
            const DeepCollectionEquality().equals(
              primarySmall,
              other.primarySmall,
            ) &&
            const DeepCollectionEquality().equals(
              transparentLarge,
              other.transparentLarge,
            ) &&
            const DeepCollectionEquality().equals(
              transparentMedium,
              other.transparentMedium,
            ) &&
            const DeepCollectionEquality().equals(
              transparentSmall,
              other.transparentSmall,
            ) &&
            const DeepCollectionEquality().equals(
              primaryIcon,
              other.primaryIcon,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(primaryLarge),
      const DeepCollectionEquality().hash(primaryMedium),
      const DeepCollectionEquality().hash(primarySmall),
      const DeepCollectionEquality().hash(transparentLarge),
      const DeepCollectionEquality().hash(transparentMedium),
      const DeepCollectionEquality().hash(transparentSmall),
      const DeepCollectionEquality().hash(primaryIcon),
    );
  }
}

extension AppButtonSchemeBuildContext on BuildContext {
  AppButtonScheme get appButtonScheme => Theme.of(this).extension<AppButtonScheme>()!;
}
