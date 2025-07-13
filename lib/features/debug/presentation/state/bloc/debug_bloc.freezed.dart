// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebugEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebugEvent()';
}


}

/// @nodoc
class $DebugEventCopyWith<$Res>  {
$DebugEventCopyWith(DebugEvent _, $Res Function(DebugEvent) __);
}


/// @nodoc


class DebugInitialize with DiagnosticableTreeMixin implements DebugEvent {
  const DebugInitialize({required this.environmentUrl});
  

 final  Urls environmentUrl;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugInitializeCopyWith<DebugInitialize> get copyWith => _$DebugInitializeCopyWithImpl<DebugInitialize>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebugEvent.initialize'))
    ..add(DiagnosticsProperty('environmentUrl', environmentUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugInitialize&&(identical(other.environmentUrl, environmentUrl) || other.environmentUrl == environmentUrl));
}


@override
int get hashCode => Object.hash(runtimeType,environmentUrl);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebugEvent.initialize(environmentUrl: $environmentUrl)';
}


}

/// @nodoc
abstract mixin class $DebugInitializeCopyWith<$Res> implements $DebugEventCopyWith<$Res> {
  factory $DebugInitializeCopyWith(DebugInitialize value, $Res Function(DebugInitialize) _then) = _$DebugInitializeCopyWithImpl;
@useResult
$Res call({
 Urls environmentUrl
});




}
/// @nodoc
class _$DebugInitializeCopyWithImpl<$Res>
    implements $DebugInitializeCopyWith<$Res> {
  _$DebugInitializeCopyWithImpl(this._self, this._then);

  final DebugInitialize _self;
  final $Res Function(DebugInitialize) _then;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? environmentUrl = null,}) {
  return _then(DebugInitialize(
environmentUrl: null == environmentUrl ? _self.environmentUrl : environmentUrl // ignore: cast_nullable_to_non_nullable
as Urls,
  ));
}


}

/// @nodoc


class DebugSetBaseUrl with DiagnosticableTreeMixin implements DebugEvent {
  const DebugSetBaseUrl({required this.baseUrl});
  

 final  Urls baseUrl;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugSetBaseUrlCopyWith<DebugSetBaseUrl> get copyWith => _$DebugSetBaseUrlCopyWithImpl<DebugSetBaseUrl>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebugEvent.setBaseUrl'))
    ..add(DiagnosticsProperty('baseUrl', baseUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugSetBaseUrl&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebugEvent.setBaseUrl(baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class $DebugSetBaseUrlCopyWith<$Res> implements $DebugEventCopyWith<$Res> {
  factory $DebugSetBaseUrlCopyWith(DebugSetBaseUrl value, $Res Function(DebugSetBaseUrl) _then) = _$DebugSetBaseUrlCopyWithImpl;
@useResult
$Res call({
 Urls baseUrl
});




}
/// @nodoc
class _$DebugSetBaseUrlCopyWithImpl<$Res>
    implements $DebugSetBaseUrlCopyWith<$Res> {
  _$DebugSetBaseUrlCopyWithImpl(this._self, this._then);

  final DebugSetBaseUrl _self;
  final $Res Function(DebugSetBaseUrl) _then;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,}) {
  return _then(DebugSetBaseUrl(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Urls,
  ));
}


}

/// @nodoc
mixin _$DebugState implements DiagnosticableTreeMixin {

 Urls? get baseUrl;
/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugStateCopyWith<DebugState> get copyWith => _$DebugStateCopyWithImpl<DebugState>(this as DebugState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebugState'))
    ..add(DiagnosticsProperty('baseUrl', baseUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugState&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebugState(baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class $DebugStateCopyWith<$Res>  {
  factory $DebugStateCopyWith(DebugState value, $Res Function(DebugState) _then) = _$DebugStateCopyWithImpl;
@useResult
$Res call({
 Urls? baseUrl
});




}
/// @nodoc
class _$DebugStateCopyWithImpl<$Res>
    implements $DebugStateCopyWith<$Res> {
  _$DebugStateCopyWithImpl(this._self, this._then);

  final DebugState _self;
  final $Res Function(DebugState) _then;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = freezed,}) {
  return _then(_self.copyWith(
baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Urls?,
  ));
}

}


/// @nodoc


class _DebugState with DiagnosticableTreeMixin implements DebugState {
  const _DebugState({this.baseUrl});
  

@override final  Urls? baseUrl;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugStateCopyWith<_DebugState> get copyWith => __$DebugStateCopyWithImpl<_DebugState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebugState'))
    ..add(DiagnosticsProperty('baseUrl', baseUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugState&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebugState(baseUrl: $baseUrl)';
}


}

/// @nodoc
abstract mixin class _$DebugStateCopyWith<$Res> implements $DebugStateCopyWith<$Res> {
  factory _$DebugStateCopyWith(_DebugState value, $Res Function(_DebugState) _then) = __$DebugStateCopyWithImpl;
@override @useResult
$Res call({
 Urls? baseUrl
});




}
/// @nodoc
class __$DebugStateCopyWithImpl<$Res>
    implements _$DebugStateCopyWith<$Res> {
  __$DebugStateCopyWithImpl(this._self, this._then);

  final _DebugState _self;
  final $Res Function(_DebugState) _then;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = freezed,}) {
  return _then(_DebugState(
baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Urls?,
  ));
}


}

// dart format on
