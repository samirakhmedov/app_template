// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'haptics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HapticsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsEvent()';
}


}

/// @nodoc
class $HapticsEventCopyWith<$Res>  {
$HapticsEventCopyWith(HapticsEvent _, $Res Function(HapticsEvent) __);
}


/// @nodoc


class HapticsInitialize implements HapticsEvent {
  const HapticsInitialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsEvent.initialize()';
}


}




/// @nodoc


class HapticsTriggerImpact implements HapticsEvent {
  const HapticsTriggerImpact(this.type);
  

 final  HapticImpactType type;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HapticsTriggerImpactCopyWith<HapticsTriggerImpact> get copyWith => _$HapticsTriggerImpactCopyWithImpl<HapticsTriggerImpact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsTriggerImpact&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'HapticsEvent.triggerImpact(type: $type)';
}


}

/// @nodoc
abstract mixin class $HapticsTriggerImpactCopyWith<$Res> implements $HapticsEventCopyWith<$Res> {
  factory $HapticsTriggerImpactCopyWith(HapticsTriggerImpact value, $Res Function(HapticsTriggerImpact) _then) = _$HapticsTriggerImpactCopyWithImpl;
@useResult
$Res call({
 HapticImpactType type
});




}
/// @nodoc
class _$HapticsTriggerImpactCopyWithImpl<$Res>
    implements $HapticsTriggerImpactCopyWith<$Res> {
  _$HapticsTriggerImpactCopyWithImpl(this._self, this._then);

  final HapticsTriggerImpact _self;
  final $Res Function(HapticsTriggerImpact) _then;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(HapticsTriggerImpact(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HapticImpactType,
  ));
}


}

/// @nodoc


class HapticsTriggerNotification implements HapticsEvent {
  const HapticsTriggerNotification(this.type);
  

 final  HapticNotificationType type;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HapticsTriggerNotificationCopyWith<HapticsTriggerNotification> get copyWith => _$HapticsTriggerNotificationCopyWithImpl<HapticsTriggerNotification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsTriggerNotification&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'HapticsEvent.triggerNotification(type: $type)';
}


}

/// @nodoc
abstract mixin class $HapticsTriggerNotificationCopyWith<$Res> implements $HapticsEventCopyWith<$Res> {
  factory $HapticsTriggerNotificationCopyWith(HapticsTriggerNotification value, $Res Function(HapticsTriggerNotification) _then) = _$HapticsTriggerNotificationCopyWithImpl;
@useResult
$Res call({
 HapticNotificationType type
});




}
/// @nodoc
class _$HapticsTriggerNotificationCopyWithImpl<$Res>
    implements $HapticsTriggerNotificationCopyWith<$Res> {
  _$HapticsTriggerNotificationCopyWithImpl(this._self, this._then);

  final HapticsTriggerNotification _self;
  final $Res Function(HapticsTriggerNotification) _then;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(HapticsTriggerNotification(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HapticNotificationType,
  ));
}


}

/// @nodoc


class HapticsTriggerFeedback implements HapticsEvent {
  const HapticsTriggerFeedback(this.type);
  

 final  HapticFeedbackType type;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HapticsTriggerFeedbackCopyWith<HapticsTriggerFeedback> get copyWith => _$HapticsTriggerFeedbackCopyWithImpl<HapticsTriggerFeedback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsTriggerFeedback&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'HapticsEvent.triggerFeedback(type: $type)';
}


}

/// @nodoc
abstract mixin class $HapticsTriggerFeedbackCopyWith<$Res> implements $HapticsEventCopyWith<$Res> {
  factory $HapticsTriggerFeedbackCopyWith(HapticsTriggerFeedback value, $Res Function(HapticsTriggerFeedback) _then) = _$HapticsTriggerFeedbackCopyWithImpl;
@useResult
$Res call({
 HapticFeedbackType type
});




}
/// @nodoc
class _$HapticsTriggerFeedbackCopyWithImpl<$Res>
    implements $HapticsTriggerFeedbackCopyWith<$Res> {
  _$HapticsTriggerFeedbackCopyWithImpl(this._self, this._then);

  final HapticsTriggerFeedback _self;
  final $Res Function(HapticsTriggerFeedback) _then;

/// Create a copy of HapticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(HapticsTriggerFeedback(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HapticFeedbackType,
  ));
}


}

/// @nodoc


class HapticsTriggerSelection implements HapticsEvent {
  const HapticsTriggerSelection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsTriggerSelection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsEvent.triggerSelection()';
}


}




/// @nodoc
mixin _$HapticsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsState()';
}


}

/// @nodoc
class $HapticsStateCopyWith<$Res>  {
$HapticsStateCopyWith(HapticsState _, $Res Function(HapticsState) __);
}


/// @nodoc


class HapticsStateInitial implements HapticsState {
  const HapticsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsState.initial()';
}


}




/// @nodoc


class HapticsStateReady implements HapticsState {
  const HapticsStateReady();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HapticsStateReady);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HapticsState.ready()';
}


}




// dart format on
