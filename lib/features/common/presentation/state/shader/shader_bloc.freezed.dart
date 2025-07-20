// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shader_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShaderEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent()';
}


}

/// @nodoc
class $ShaderEventCopyWith<$Res>  {
$ShaderEventCopyWith(ShaderEvent _, $Res Function(ShaderEvent) __);
}


/// @nodoc


class ShaderInitialize with DiagnosticableTreeMixin implements ShaderEvent {
  const ShaderInitialize();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent.initialize'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent.initialize()';
}


}




/// @nodoc


class ShaderLoadShimmer with DiagnosticableTreeMixin implements ShaderEvent {
  const ShaderLoadShimmer();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent.loadShimmer'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderLoadShimmer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent.loadShimmer()';
}


}




/// @nodoc


class ShaderLoadShader with DiagnosticableTreeMixin implements ShaderEvent {
  const ShaderLoadShader(this.shaderType);
  

 final  ShaderType shaderType;

/// Create a copy of ShaderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShaderLoadShaderCopyWith<ShaderLoadShader> get copyWith => _$ShaderLoadShaderCopyWithImpl<ShaderLoadShader>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent.loadShader'))
    ..add(DiagnosticsProperty('shaderType', shaderType));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderLoadShader&&(identical(other.shaderType, shaderType) || other.shaderType == shaderType));
}


@override
int get hashCode => Object.hash(runtimeType,shaderType);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent.loadShader(shaderType: $shaderType)';
}


}

/// @nodoc
abstract mixin class $ShaderLoadShaderCopyWith<$Res> implements $ShaderEventCopyWith<$Res> {
  factory $ShaderLoadShaderCopyWith(ShaderLoadShader value, $Res Function(ShaderLoadShader) _then) = _$ShaderLoadShaderCopyWithImpl;
@useResult
$Res call({
 ShaderType shaderType
});




}
/// @nodoc
class _$ShaderLoadShaderCopyWithImpl<$Res>
    implements $ShaderLoadShaderCopyWith<$Res> {
  _$ShaderLoadShaderCopyWithImpl(this._self, this._then);

  final ShaderLoadShader _self;
  final $Res Function(ShaderLoadShader) _then;

/// Create a copy of ShaderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shaderType = null,}) {
  return _then(ShaderLoadShader(
null == shaderType ? _self.shaderType : shaderType // ignore: cast_nullable_to_non_nullable
as ShaderType,
  ));
}


}

/// @nodoc


class ShaderHandleMemoryPressure with DiagnosticableTreeMixin implements ShaderEvent {
  const ShaderHandleMemoryPressure();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent.handleMemoryPressure'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderHandleMemoryPressure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent.handleMemoryPressure()';
}


}




/// @nodoc


class _ShaderUpdateState with DiagnosticableTreeMixin implements ShaderEvent {
  const _ShaderUpdateState(final  Map<ShaderType, ui.FragmentShader?> shaders): _shaders = shaders;
  

 final  Map<ShaderType, ui.FragmentShader?> _shaders;
 Map<ShaderType, ui.FragmentShader?> get shaders {
  if (_shaders is EqualUnmodifiableMapView) return _shaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_shaders);
}


/// Create a copy of ShaderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShaderUpdateStateCopyWith<_ShaderUpdateState> get copyWith => __$ShaderUpdateStateCopyWithImpl<_ShaderUpdateState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderEvent._updateState'))
    ..add(DiagnosticsProperty('shaders', shaders));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShaderUpdateState&&const DeepCollectionEquality().equals(other._shaders, _shaders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shaders));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderEvent._updateState(shaders: $shaders)';
}


}

/// @nodoc
abstract mixin class _$ShaderUpdateStateCopyWith<$Res> implements $ShaderEventCopyWith<$Res> {
  factory _$ShaderUpdateStateCopyWith(_ShaderUpdateState value, $Res Function(_ShaderUpdateState) _then) = __$ShaderUpdateStateCopyWithImpl;
@useResult
$Res call({
 Map<ShaderType, ui.FragmentShader?> shaders
});




}
/// @nodoc
class __$ShaderUpdateStateCopyWithImpl<$Res>
    implements _$ShaderUpdateStateCopyWith<$Res> {
  __$ShaderUpdateStateCopyWithImpl(this._self, this._then);

  final _ShaderUpdateState _self;
  final $Res Function(_ShaderUpdateState) _then;

/// Create a copy of ShaderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shaders = null,}) {
  return _then(_ShaderUpdateState(
null == shaders ? _self._shaders : shaders // ignore: cast_nullable_to_non_nullable
as Map<ShaderType, ui.FragmentShader?>,
  ));
}


}

/// @nodoc
mixin _$ShaderState implements DiagnosticableTreeMixin {

/// Map of shader types to their loaded fragment shaders.
 Map<ShaderType, ui.FragmentShader?> get shaders;
/// Create a copy of ShaderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShaderStateCopyWith<ShaderState> get copyWith => _$ShaderStateCopyWithImpl<ShaderState>(this as ShaderState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderState'))
    ..add(DiagnosticsProperty('shaders', shaders));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShaderState&&const DeepCollectionEquality().equals(other.shaders, shaders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shaders));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderState(shaders: $shaders)';
}


}

/// @nodoc
abstract mixin class $ShaderStateCopyWith<$Res>  {
  factory $ShaderStateCopyWith(ShaderState value, $Res Function(ShaderState) _then) = _$ShaderStateCopyWithImpl;
@useResult
$Res call({
 Map<ShaderType, ui.FragmentShader?> shaders
});




}
/// @nodoc
class _$ShaderStateCopyWithImpl<$Res>
    implements $ShaderStateCopyWith<$Res> {
  _$ShaderStateCopyWithImpl(this._self, this._then);

  final ShaderState _self;
  final $Res Function(ShaderState) _then;

/// Create a copy of ShaderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shaders = null,}) {
  return _then(_self.copyWith(
shaders: null == shaders ? _self.shaders : shaders // ignore: cast_nullable_to_non_nullable
as Map<ShaderType, ui.FragmentShader?>,
  ));
}

}


/// @nodoc


class _ShaderState with DiagnosticableTreeMixin implements ShaderState {
  const _ShaderState({final  Map<ShaderType, ui.FragmentShader?> shaders = const {}}): _shaders = shaders;
  

/// Map of shader types to their loaded fragment shaders.
 final  Map<ShaderType, ui.FragmentShader?> _shaders;
/// Map of shader types to their loaded fragment shaders.
@override@JsonKey() Map<ShaderType, ui.FragmentShader?> get shaders {
  if (_shaders is EqualUnmodifiableMapView) return _shaders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_shaders);
}


/// Create a copy of ShaderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShaderStateCopyWith<_ShaderState> get copyWith => __$ShaderStateCopyWithImpl<_ShaderState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ShaderState'))
    ..add(DiagnosticsProperty('shaders', shaders));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShaderState&&const DeepCollectionEquality().equals(other._shaders, _shaders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shaders));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ShaderState(shaders: $shaders)';
}


}

/// @nodoc
abstract mixin class _$ShaderStateCopyWith<$Res> implements $ShaderStateCopyWith<$Res> {
  factory _$ShaderStateCopyWith(_ShaderState value, $Res Function(_ShaderState) _then) = __$ShaderStateCopyWithImpl;
@override @useResult
$Res call({
 Map<ShaderType, ui.FragmentShader?> shaders
});




}
/// @nodoc
class __$ShaderStateCopyWithImpl<$Res>
    implements _$ShaderStateCopyWith<$Res> {
  __$ShaderStateCopyWithImpl(this._self, this._then);

  final _ShaderState _self;
  final $Res Function(_ShaderState) _then;

/// Create a copy of ShaderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shaders = null,}) {
  return _then(_ShaderState(
shaders: null == shaders ? _self._shaders : shaders // ignore: cast_nullable_to_non_nullable
as Map<ShaderType, ui.FragmentShader?>,
  ));
}


}

// dart format on
