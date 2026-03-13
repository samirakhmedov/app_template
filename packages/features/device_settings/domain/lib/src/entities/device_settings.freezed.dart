// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceSettings {

 int? get refreshRate; List<AppDeviceOrientation> get orientations; AppSystemUiMode get systemUiMode; AppSystemUiOverlayStyle? get overlayStyle;
/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<DeviceSettings> get copyWith => _$DeviceSettingsCopyWithImpl<DeviceSettings>(this as DeviceSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettings&&(identical(other.refreshRate, refreshRate) || other.refreshRate == refreshRate)&&const DeepCollectionEquality().equals(other.orientations, orientations)&&(identical(other.systemUiMode, systemUiMode) || other.systemUiMode == systemUiMode)&&(identical(other.overlayStyle, overlayStyle) || other.overlayStyle == overlayStyle));
}


@override
int get hashCode => Object.hash(runtimeType,refreshRate,const DeepCollectionEquality().hash(orientations),systemUiMode,overlayStyle);

@override
String toString() {
  return 'DeviceSettings(refreshRate: $refreshRate, orientations: $orientations, systemUiMode: $systemUiMode, overlayStyle: $overlayStyle)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsCopyWith<$Res>  {
  factory $DeviceSettingsCopyWith(DeviceSettings value, $Res Function(DeviceSettings) _then) = _$DeviceSettingsCopyWithImpl;
@useResult
$Res call({
 int? refreshRate, List<AppDeviceOrientation> orientations, AppSystemUiMode systemUiMode, AppSystemUiOverlayStyle? overlayStyle
});




}
/// @nodoc
class _$DeviceSettingsCopyWithImpl<$Res>
    implements $DeviceSettingsCopyWith<$Res> {
  _$DeviceSettingsCopyWithImpl(this._self, this._then);

  final DeviceSettings _self;
  final $Res Function(DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshRate = freezed,Object? orientations = null,Object? systemUiMode = null,Object? overlayStyle = freezed,}) {
  return _then(_self.copyWith(
refreshRate: freezed == refreshRate ? _self.refreshRate : refreshRate // ignore: cast_nullable_to_non_nullable
as int?,orientations: null == orientations ? _self.orientations : orientations // ignore: cast_nullable_to_non_nullable
as List<AppDeviceOrientation>,systemUiMode: null == systemUiMode ? _self.systemUiMode : systemUiMode // ignore: cast_nullable_to_non_nullable
as AppSystemUiMode,overlayStyle: freezed == overlayStyle ? _self.overlayStyle : overlayStyle // ignore: cast_nullable_to_non_nullable
as AppSystemUiOverlayStyle?,
  ));
}

}


/// @nodoc


class _DeviceSettings implements DeviceSettings {
  const _DeviceSettings({this.refreshRate = null, final  List<AppDeviceOrientation> orientations = const [AppDeviceOrientation.portraitUp, AppDeviceOrientation.portraitDown], this.systemUiMode = AppSystemUiMode.edgeToEdge, this.overlayStyle}): _orientations = orientations;
  

@override@JsonKey() final  int? refreshRate;
 final  List<AppDeviceOrientation> _orientations;
@override@JsonKey() List<AppDeviceOrientation> get orientations {
  if (_orientations is EqualUnmodifiableListView) return _orientations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orientations);
}

@override@JsonKey() final  AppSystemUiMode systemUiMode;
@override final  AppSystemUiOverlayStyle? overlayStyle;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsCopyWith<_DeviceSettings> get copyWith => __$DeviceSettingsCopyWithImpl<_DeviceSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettings&&(identical(other.refreshRate, refreshRate) || other.refreshRate == refreshRate)&&const DeepCollectionEquality().equals(other._orientations, _orientations)&&(identical(other.systemUiMode, systemUiMode) || other.systemUiMode == systemUiMode)&&(identical(other.overlayStyle, overlayStyle) || other.overlayStyle == overlayStyle));
}


@override
int get hashCode => Object.hash(runtimeType,refreshRate,const DeepCollectionEquality().hash(_orientations),systemUiMode,overlayStyle);

@override
String toString() {
  return 'DeviceSettings(refreshRate: $refreshRate, orientations: $orientations, systemUiMode: $systemUiMode, overlayStyle: $overlayStyle)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsCopyWith<$Res> implements $DeviceSettingsCopyWith<$Res> {
  factory _$DeviceSettingsCopyWith(_DeviceSettings value, $Res Function(_DeviceSettings) _then) = __$DeviceSettingsCopyWithImpl;
@override @useResult
$Res call({
 int? refreshRate, List<AppDeviceOrientation> orientations, AppSystemUiMode systemUiMode, AppSystemUiOverlayStyle? overlayStyle
});




}
/// @nodoc
class __$DeviceSettingsCopyWithImpl<$Res>
    implements _$DeviceSettingsCopyWith<$Res> {
  __$DeviceSettingsCopyWithImpl(this._self, this._then);

  final _DeviceSettings _self;
  final $Res Function(_DeviceSettings) _then;

/// Create a copy of DeviceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshRate = freezed,Object? orientations = null,Object? systemUiMode = null,Object? overlayStyle = freezed,}) {
  return _then(_DeviceSettings(
refreshRate: freezed == refreshRate ? _self.refreshRate : refreshRate // ignore: cast_nullable_to_non_nullable
as int?,orientations: null == orientations ? _self._orientations : orientations // ignore: cast_nullable_to_non_nullable
as List<AppDeviceOrientation>,systemUiMode: null == systemUiMode ? _self.systemUiMode : systemUiMode // ignore: cast_nullable_to_non_nullable
as AppSystemUiMode,overlayStyle: freezed == overlayStyle ? _self.overlayStyle : overlayStyle // ignore: cast_nullable_to_non_nullable
as AppSystemUiOverlayStyle?,
  ));
}


}

// dart format on
