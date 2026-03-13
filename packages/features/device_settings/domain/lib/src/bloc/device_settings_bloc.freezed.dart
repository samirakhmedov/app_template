// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeviceSettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceSettingsEvent()';
}


}

/// @nodoc
class $DeviceSettingsEventCopyWith<$Res>  {
$DeviceSettingsEventCopyWith(DeviceSettingsEvent _, $Res Function(DeviceSettingsEvent) __);
}


/// @nodoc


class DeviceSettingsInitialize implements DeviceSettingsEvent {
  const DeviceSettingsInitialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DeviceSettingsEvent.initialize()';
}


}




/// @nodoc


class DeviceSettingsSetRefreshRate implements DeviceSettingsEvent {
  const DeviceSettingsSetRefreshRate(this.rate);
  

 final  int? rate;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsSetRefreshRateCopyWith<DeviceSettingsSetRefreshRate> get copyWith => _$DeviceSettingsSetRefreshRateCopyWithImpl<DeviceSettingsSetRefreshRate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsSetRefreshRate&&(identical(other.rate, rate) || other.rate == rate));
}


@override
int get hashCode => Object.hash(runtimeType,rate);

@override
String toString() {
  return 'DeviceSettingsEvent.setRefreshRate(rate: $rate)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsSetRefreshRateCopyWith<$Res> implements $DeviceSettingsEventCopyWith<$Res> {
  factory $DeviceSettingsSetRefreshRateCopyWith(DeviceSettingsSetRefreshRate value, $Res Function(DeviceSettingsSetRefreshRate) _then) = _$DeviceSettingsSetRefreshRateCopyWithImpl;
@useResult
$Res call({
 int? rate
});




}
/// @nodoc
class _$DeviceSettingsSetRefreshRateCopyWithImpl<$Res>
    implements $DeviceSettingsSetRefreshRateCopyWith<$Res> {
  _$DeviceSettingsSetRefreshRateCopyWithImpl(this._self, this._then);

  final DeviceSettingsSetRefreshRate _self;
  final $Res Function(DeviceSettingsSetRefreshRate) _then;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rate = freezed,}) {
  return _then(DeviceSettingsSetRefreshRate(
freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class DeviceSettingsSetOrientations implements DeviceSettingsEvent {
  const DeviceSettingsSetOrientations(final  List<AppDeviceOrientation> orientations): _orientations = orientations;
  

 final  List<AppDeviceOrientation> _orientations;
 List<AppDeviceOrientation> get orientations {
  if (_orientations is EqualUnmodifiableListView) return _orientations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orientations);
}


/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsSetOrientationsCopyWith<DeviceSettingsSetOrientations> get copyWith => _$DeviceSettingsSetOrientationsCopyWithImpl<DeviceSettingsSetOrientations>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsSetOrientations&&const DeepCollectionEquality().equals(other._orientations, _orientations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orientations));

@override
String toString() {
  return 'DeviceSettingsEvent.setOrientations(orientations: $orientations)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsSetOrientationsCopyWith<$Res> implements $DeviceSettingsEventCopyWith<$Res> {
  factory $DeviceSettingsSetOrientationsCopyWith(DeviceSettingsSetOrientations value, $Res Function(DeviceSettingsSetOrientations) _then) = _$DeviceSettingsSetOrientationsCopyWithImpl;
@useResult
$Res call({
 List<AppDeviceOrientation> orientations
});




}
/// @nodoc
class _$DeviceSettingsSetOrientationsCopyWithImpl<$Res>
    implements $DeviceSettingsSetOrientationsCopyWith<$Res> {
  _$DeviceSettingsSetOrientationsCopyWithImpl(this._self, this._then);

  final DeviceSettingsSetOrientations _self;
  final $Res Function(DeviceSettingsSetOrientations) _then;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orientations = null,}) {
  return _then(DeviceSettingsSetOrientations(
null == orientations ? _self._orientations : orientations // ignore: cast_nullable_to_non_nullable
as List<AppDeviceOrientation>,
  ));
}


}

/// @nodoc


class DeviceSettingsSetSystemUiMode implements DeviceSettingsEvent {
  const DeviceSettingsSetSystemUiMode(this.mode);
  

 final  AppSystemUiMode mode;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsSetSystemUiModeCopyWith<DeviceSettingsSetSystemUiMode> get copyWith => _$DeviceSettingsSetSystemUiModeCopyWithImpl<DeviceSettingsSetSystemUiMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsSetSystemUiMode&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'DeviceSettingsEvent.setSystemUiMode(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsSetSystemUiModeCopyWith<$Res> implements $DeviceSettingsEventCopyWith<$Res> {
  factory $DeviceSettingsSetSystemUiModeCopyWith(DeviceSettingsSetSystemUiMode value, $Res Function(DeviceSettingsSetSystemUiMode) _then) = _$DeviceSettingsSetSystemUiModeCopyWithImpl;
@useResult
$Res call({
 AppSystemUiMode mode
});




}
/// @nodoc
class _$DeviceSettingsSetSystemUiModeCopyWithImpl<$Res>
    implements $DeviceSettingsSetSystemUiModeCopyWith<$Res> {
  _$DeviceSettingsSetSystemUiModeCopyWithImpl(this._self, this._then);

  final DeviceSettingsSetSystemUiMode _self;
  final $Res Function(DeviceSettingsSetSystemUiMode) _then;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(DeviceSettingsSetSystemUiMode(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppSystemUiMode,
  ));
}


}

/// @nodoc


class DeviceSettingsSetOverlayStyle implements DeviceSettingsEvent {
  const DeviceSettingsSetOverlayStyle(this.style);
  

 final  AppSystemUiOverlayStyle? style;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsSetOverlayStyleCopyWith<DeviceSettingsSetOverlayStyle> get copyWith => _$DeviceSettingsSetOverlayStyleCopyWithImpl<DeviceSettingsSetOverlayStyle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsSetOverlayStyle&&(identical(other.style, style) || other.style == style));
}


@override
int get hashCode => Object.hash(runtimeType,style);

@override
String toString() {
  return 'DeviceSettingsEvent.setOverlayStyle(style: $style)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsSetOverlayStyleCopyWith<$Res> implements $DeviceSettingsEventCopyWith<$Res> {
  factory $DeviceSettingsSetOverlayStyleCopyWith(DeviceSettingsSetOverlayStyle value, $Res Function(DeviceSettingsSetOverlayStyle) _then) = _$DeviceSettingsSetOverlayStyleCopyWithImpl;
@useResult
$Res call({
 AppSystemUiOverlayStyle? style
});




}
/// @nodoc
class _$DeviceSettingsSetOverlayStyleCopyWithImpl<$Res>
    implements $DeviceSettingsSetOverlayStyleCopyWith<$Res> {
  _$DeviceSettingsSetOverlayStyleCopyWithImpl(this._self, this._then);

  final DeviceSettingsSetOverlayStyle _self;
  final $Res Function(DeviceSettingsSetOverlayStyle) _then;

/// Create a copy of DeviceSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? style = freezed,}) {
  return _then(DeviceSettingsSetOverlayStyle(
freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as AppSystemUiOverlayStyle?,
  ));
}


}

/// @nodoc
mixin _$DeviceSettingsState {

 DeviceSettings get settings; bool get isInitialized;
/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSettingsStateCopyWith<DeviceSettingsState> get copyWith => _$DeviceSettingsStateCopyWithImpl<DeviceSettingsState>(this as DeviceSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isInitialized);

@override
String toString() {
  return 'DeviceSettingsState(settings: $settings, isInitialized: $isInitialized)';
}


}

/// @nodoc
abstract mixin class $DeviceSettingsStateCopyWith<$Res>  {
  factory $DeviceSettingsStateCopyWith(DeviceSettingsState value, $Res Function(DeviceSettingsState) _then) = _$DeviceSettingsStateCopyWithImpl;
@useResult
$Res call({
 DeviceSettings settings, bool isInitialized
});


$DeviceSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$DeviceSettingsStateCopyWithImpl<$Res>
    implements $DeviceSettingsStateCopyWith<$Res> {
  _$DeviceSettingsStateCopyWithImpl(this._self, this._then);

  final DeviceSettingsState _self;
  final $Res Function(DeviceSettingsState) _then;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? isInitialized = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DeviceSettings,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<$Res> get settings {
  
  return $DeviceSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// @nodoc


class _DeviceSettingsState implements DeviceSettingsState {
  const _DeviceSettingsState({this.settings = const DeviceSettings(), this.isInitialized = false});
  

@override@JsonKey() final  DeviceSettings settings;
@override@JsonKey() final  bool isInitialized;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSettingsStateCopyWith<_DeviceSettingsState> get copyWith => __$DeviceSettingsStateCopyWithImpl<_DeviceSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized));
}


@override
int get hashCode => Object.hash(runtimeType,settings,isInitialized);

@override
String toString() {
  return 'DeviceSettingsState(settings: $settings, isInitialized: $isInitialized)';
}


}

/// @nodoc
abstract mixin class _$DeviceSettingsStateCopyWith<$Res> implements $DeviceSettingsStateCopyWith<$Res> {
  factory _$DeviceSettingsStateCopyWith(_DeviceSettingsState value, $Res Function(_DeviceSettingsState) _then) = __$DeviceSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 DeviceSettings settings, bool isInitialized
});


@override $DeviceSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$DeviceSettingsStateCopyWithImpl<$Res>
    implements _$DeviceSettingsStateCopyWith<$Res> {
  __$DeviceSettingsStateCopyWithImpl(this._self, this._then);

  final _DeviceSettingsState _self;
  final $Res Function(_DeviceSettingsState) _then;

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? isInitialized = null,}) {
  return _then(_DeviceSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as DeviceSettings,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DeviceSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceSettingsCopyWith<$Res> get settings {
  
  return $DeviceSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
