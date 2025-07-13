// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snack_queue_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SnackQueueEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackQueueEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SnackQueueEvent()';
}


}

/// @nodoc
class $SnackQueueEventCopyWith<$Res>  {
$SnackQueueEventCopyWith(SnackQueueEvent _, $Res Function(SnackQueueEvent) __);
}


/// @nodoc


class SnackQueueAdd implements SnackQueueEvent {
  const SnackQueueAdd(this.snack);
  

 final  TopSnackBar snack;

/// Create a copy of SnackQueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackQueueAddCopyWith<SnackQueueAdd> get copyWith => _$SnackQueueAddCopyWithImpl<SnackQueueAdd>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackQueueAdd&&(identical(other.snack, snack) || other.snack == snack));
}


@override
int get hashCode => Object.hash(runtimeType,snack);

@override
String toString() {
  return 'SnackQueueEvent.add(snack: $snack)';
}


}

/// @nodoc
abstract mixin class $SnackQueueAddCopyWith<$Res> implements $SnackQueueEventCopyWith<$Res> {
  factory $SnackQueueAddCopyWith(SnackQueueAdd value, $Res Function(SnackQueueAdd) _then) = _$SnackQueueAddCopyWithImpl;
@useResult
$Res call({
 TopSnackBar snack
});




}
/// @nodoc
class _$SnackQueueAddCopyWithImpl<$Res>
    implements $SnackQueueAddCopyWith<$Res> {
  _$SnackQueueAddCopyWithImpl(this._self, this._then);

  final SnackQueueAdd _self;
  final $Res Function(SnackQueueAdd) _then;

/// Create a copy of SnackQueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? snack = null,}) {
  return _then(SnackQueueAdd(
null == snack ? _self.snack : snack // ignore: cast_nullable_to_non_nullable
as TopSnackBar,
  ));
}


}

/// @nodoc


class SnackQueueClear implements SnackQueueEvent {
  const SnackQueueClear(this.closeTime);
  

 final  DateTime closeTime;

/// Create a copy of SnackQueueEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackQueueClearCopyWith<SnackQueueClear> get copyWith => _$SnackQueueClearCopyWithImpl<SnackQueueClear>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackQueueClear&&(identical(other.closeTime, closeTime) || other.closeTime == closeTime));
}


@override
int get hashCode => Object.hash(runtimeType,closeTime);

@override
String toString() {
  return 'SnackQueueEvent.clear(closeTime: $closeTime)';
}


}

/// @nodoc
abstract mixin class $SnackQueueClearCopyWith<$Res> implements $SnackQueueEventCopyWith<$Res> {
  factory $SnackQueueClearCopyWith(SnackQueueClear value, $Res Function(SnackQueueClear) _then) = _$SnackQueueClearCopyWithImpl;
@useResult
$Res call({
 DateTime closeTime
});




}
/// @nodoc
class _$SnackQueueClearCopyWithImpl<$Res>
    implements $SnackQueueClearCopyWith<$Res> {
  _$SnackQueueClearCopyWithImpl(this._self, this._then);

  final SnackQueueClear _self;
  final $Res Function(SnackQueueClear) _then;

/// Create a copy of SnackQueueEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? closeTime = null,}) {
  return _then(SnackQueueClear(
null == closeTime ? _self.closeTime : closeTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class SnackQueueRemoveFirst implements SnackQueueEvent {
  const SnackQueueRemoveFirst();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackQueueRemoveFirst);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SnackQueueEvent.removeFirst()';
}


}




/// @nodoc
mixin _$SnackQueueState {

 Queue<TopSnackBar> get queue;
/// Create a copy of SnackQueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnackQueueStateCopyWith<SnackQueueState> get copyWith => _$SnackQueueStateCopyWithImpl<SnackQueueState>(this as SnackQueueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnackQueueState&&const DeepCollectionEquality().equals(other.queue, queue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(queue));

@override
String toString() {
  return 'SnackQueueState(queue: $queue)';
}


}

/// @nodoc
abstract mixin class $SnackQueueStateCopyWith<$Res>  {
  factory $SnackQueueStateCopyWith(SnackQueueState value, $Res Function(SnackQueueState) _then) = _$SnackQueueStateCopyWithImpl;
@useResult
$Res call({
 Queue<TopSnackBar> queue
});




}
/// @nodoc
class _$SnackQueueStateCopyWithImpl<$Res>
    implements $SnackQueueStateCopyWith<$Res> {
  _$SnackQueueStateCopyWithImpl(this._self, this._then);

  final SnackQueueState _self;
  final $Res Function(SnackQueueState) _then;

/// Create a copy of SnackQueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queue = freezed,}) {
  return _then(_self.copyWith(
queue: freezed == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as Queue<TopSnackBar>,
  ));
}

}


/// @nodoc


class _SnackQueueState implements SnackQueueState {
  const _SnackQueueState({required this.queue});
  

@override final  Queue<TopSnackBar> queue;

/// Create a copy of SnackQueueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnackQueueStateCopyWith<_SnackQueueState> get copyWith => __$SnackQueueStateCopyWithImpl<_SnackQueueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnackQueueState&&const DeepCollectionEquality().equals(other.queue, queue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(queue));

@override
String toString() {
  return 'SnackQueueState(queue: $queue)';
}


}

/// @nodoc
abstract mixin class _$SnackQueueStateCopyWith<$Res> implements $SnackQueueStateCopyWith<$Res> {
  factory _$SnackQueueStateCopyWith(_SnackQueueState value, $Res Function(_SnackQueueState) _then) = __$SnackQueueStateCopyWithImpl;
@override @useResult
$Res call({
 Queue<TopSnackBar> queue
});




}
/// @nodoc
class __$SnackQueueStateCopyWithImpl<$Res>
    implements _$SnackQueueStateCopyWith<$Res> {
  __$SnackQueueStateCopyWithImpl(this._self, this._then);

  final _SnackQueueState _self;
  final $Res Function(_SnackQueueState) _then;

/// Create a copy of SnackQueueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queue = freezed,}) {
  return _then(_SnackQueueState(
queue: freezed == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as Queue<TopSnackBar>,
  ));
}


}

// dart format on
